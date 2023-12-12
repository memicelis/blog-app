class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :current_user

  def current_user
    @current_user ||= User.first
  end
end
