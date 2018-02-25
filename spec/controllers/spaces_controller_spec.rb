require 'rails_helper'

RSpec.describe SpacesController, type: :controller do
  context '#get_price_quote' do
    let(:space1) { Space.create(title: 'center park', size: 500, price_per_day: 200, price_per_week: 400, price_per_month: 600) }
    it 'when the duration between start_date and end date is more than one month' do
      params = { id: space1.display_id, start_date: '1-1-2018', end_date: '15-2-2018' }
      get :get_price_quote, params
      parse_json = JSON(response.body)
      parse_json['message'].should == 'Price is: 1600.0'
    end
    it 'when the duration between start_date and end date is less than one month' do
      params = { id: space1.display_id, start_date: '1-1-2018', end_date: '16-1-2018' }
      get :get_price_quote, params
      parse_json = JSON(response.body)
      parse_json['message'].should == 'Price is: 1000.0'
    end
    it 'when the duration between start_date and end date is less than one week' do
      params = { id: space1.display_id, start_date: '1-1-2018', end_date: '5-1-2018' }
      get :get_price_quote, params
      parse_json = JSON(response.body)
      parse_json['message'].should == 'Price is: 800.0'
    end
  end
end
