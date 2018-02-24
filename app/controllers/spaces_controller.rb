class SpacesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_space, only: [:show, :update, :get_price_quote]

  def create
    @space = Space.new(@json['space'])
    if @space.save
      render json: { message: "Space created successfully", space: @space }
    else
      render json: { message: @space.errors.full_messages }
    end
  end

  def index
    @spaces = Space.all
    render json: {spaces: @spaces}
  end

  def show
    render json: {space: @space}
  end

  def update
    if @space.update(@json['space'])
      render json: { message: "Space updated successfully", space: @space }
    else
      render json: { message: @space.errors.full_messages }
    end
  end

  def destroy
    @space = Space.where(id: params[:id]).first
    if @space.destroy
      render json: { message: "Space deleted successfully" }
    else
      render json: { message: "Something went wrong " }
    end
  end

  def get_price_quote
    number_of_months = remaining_days = remaining_weeks = 0
    start_date = params[:start_date].to_date
    end_date = params[:end_date].to_date
    number_of_days = (end_date - start_date).to_i
    if number_of_days >= 30
      number_of_months = number_of_days / 30
      remaining_days = number_of_days % 30
      if remaining_days > 0
        remaining_weeks = remaining_days / 7
        remaining_days = remaining_days % 7
      end
      price_quote = (@space.price_per_month * number_of_months) + (@space.price_per_week * remaining_weeks) + (@space.price_per_day * remaining_days)
    else number_of_days < 30
      remaining_weeks = number_of_days / 7
      remaining_days = number_of_days % 7
      price_quote = (@space.price_per_week * remaining_weeks) + (@space.price_per_day * remaining_days)
    end
    render json: {message: "Price is: #{price_quote}"}
  end

  private
    def find_space
      @space = Space.where(id: params[:id]).first
      render json: {message: "Item not found"} unless @space
    end
end
