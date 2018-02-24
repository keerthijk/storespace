class StoresController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_store, only: [:show, :update]

  def create
    @store = Store.new(@json['store'])
    if @store.save
      render json: { message: "Store created successfully", store: @store }
    else
      render json: { message: @store.errors.full_messages }
    end
  end

  def index
    begin
      processed_params = params.except('action', 'controller', 'store')
      if processed_params.present?
        attribute = processed_params.keys.first
        params_values = processed_params.values.first.split(':')
        value = params_values[1]
        operation = case params_values[0]
        when 'like'
          'ILIKE'
        when "eq"
          '='
        when 'gt'
          '>'
        when 'lt'
          '<'
        end
        value = "'%#{value}%'" if ['title', 'street', 'city'].include?(attribute)
        query_string = "SELECT * FROM stores where #{attribute} #{operation} #{value}"
      else
        query_string = "SELECT * FROM stores"
      end
      @stores = ActiveRecord::Base.connection.execute(query_string)
      render json: {stores: @stores}
    rescue StandardError => e
      render json: {message: e}
    end
  end

  def show
    render json: {store: @store}
  end

  def update
    if @store.update(@json['store'])
      render json: { message: "Store updated successfully", store: @store }
    else
      render json: { message: @store.errors.full_messages }
    end
  end

  def destroy
    @store = Store.where(id: params[:id]).first
    if @store.destroy
      render json: { message: "Store deleted successfully" }
    else
      render json: { message: "Something went wrong " }
    end
  end

  private
    def find_store
      @store = Store.where(id: params[:id]).first
      render json: {message: "Item not found"} unless @store
    end
end
