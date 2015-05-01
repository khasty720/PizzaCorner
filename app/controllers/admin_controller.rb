class AdminController < ApplicationController
  before_filter :authenticate_user!

  def index
    unless (@admin == current_user || current_user.employee == true)
      redirect_to root_path, :alert => "Access denied."
    end
  end
end
