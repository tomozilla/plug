class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :dashboard]

  def dashboard
    @user = User.first
  end

  def home
  end
end
