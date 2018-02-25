class SpacesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_space, only: [:show, :update, :get_price_quote, :destroy]

  def create
    @space = Space.new(space_params)
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
    if @space.update(space_params)
      render json: { message: "Space updated successfully", space: @space }
    else
      render json: { message: @space.errors.full_messages }
    end
  end

  def destroy
    if @space.destroy
      render json: { message: "Space deleted successfully" }
    else
      render json: { message: "Something went wrong " }
    end
  end

  def get_price_quote
    start_date = params[:start_date].to_date
    end_date = params[:end_date].to_date
    number_of_days = (end_date - start_date).to_i
    price_quote = calculate_price(number_of_days, 30, 7)
    render json: {message: "Price is: #{price_quote}"}
  end

  def calculate_price(number_of_days, days_in_month, days_in_week)
    number_of_months = remaining_days = remaining_weeks = 0
    number_of_months = number_of_days / days_in_month
    remaining_days = number_of_days % days_in_month
    if remaining_days > 0
      remaining_weeks = remaining_days / days_in_week
      remaining_days = remaining_days % days_in_week
    end
    price_quote = (@space.price_per_month * number_of_months) + (@space.price_per_week * remaining_weeks) + (@space.price_per_day * remaining_days)
  end

  private
    def find_space
      @space = Space.find_by_display_id(params[:id])
    end

    def space_params
      params.require(:space).permit(:title, :size, :price_per_day, :price_per_week, :price_per_month, :store_id)
    end
end
