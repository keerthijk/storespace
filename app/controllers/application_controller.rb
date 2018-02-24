class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true, with: :exception
  before_action :parse_request, only: [:create, :update]

  private
    def parse_request
      params = request.body.read
      if params.present?
        @json = JSON.parse(params)
      else
        render json: {message: "Pass params as json"}
      end
    end
end
