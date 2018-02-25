class ApplicationController < ActionController::Base
  include ExceptionHandler
  protect_from_forgery prepend: true, with: :exception
end
