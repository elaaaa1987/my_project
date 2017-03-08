class DashboardController < ApplicationController
  def index
  	@users = User.all.order("created_at DESC")
  	@roles = Role.all
  end
end
