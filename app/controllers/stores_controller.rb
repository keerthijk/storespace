class StoresController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_store, only: [:show, :update, :destroy]

  def create
    @store = Store.new(store_params)
    if @store.save
      render json: { message: 'Store created successfully', store: @store }
    else
      render json: { message: @store.errors.full_messages }
    end
  end

  def index
    processed_params = params.except('action', 'controller', 'store')
    if processed_params.present?
      attribute = processed_params.keys.first
      params_values = processed_params.values.first.split(':')
      value = params_values[1]
      operation = get_operation(params_values[0])
      value = "'%#{value}%'" if %w[title street city].include?(attribute)
      query_string = "SELECT * FROM stores where #{attribute} #{operation} #{value}"
    else
      query_string = 'SELECT * FROM stores'
    end
    @stores = ActiveRecord::Base.connection.execute(query_string)
    render json: { stores: @stores }
  rescue StandardError => e
    render json: { message: e }
  end

  def get_operation(operation_string)
    case operation_string
    when 'like'
      'ILIKE'
    when 'eq'
      '='
    when 'gt'
      '>'
    when 'lt'
      '<'
    end
  end

  def show
    render json: { store: @store }
  end

  def update
    if @store.update(store_params)
      render json: { message: 'Store updated successfully', store: @store }
    else
      render json: { message: @store.errors.full_messages }
    end
  end

  def destroy
    if @store.destroy
      render json: { message: 'Store deleted successfully' }
    else
      render json: { message: 'Something went wrong' }
    end
  end

  private

  def find_store
    @store = Store.find_by_display_store_id(params[:id])
  end

  def store_params
    params.require(:store).permit(:title, :city, :street)
  end
end
