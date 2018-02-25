require 'rails_helper'

RSpec.describe StoresController, type: :controller do
  context '#index' do
    let(:store) { Store.create(title: 'new store', city: 'Thrissur', street: 'Street one') }
    it 'when the params is having matching title' do
      params = { title: 'like:new' }
      get :index, params
      parse_json = JSON(response.body)
      parse_json['stores'].count == 1
    end
    it 'when the params is not having matching title' do
      params = { title: 'like:two' }
      get :index, params
      parse_json = JSON(response.body)
      parse_json['stores'].count == 0
    end
  end
end
