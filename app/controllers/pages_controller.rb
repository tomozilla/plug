class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :library]

  def library
    @user = User.first
  end

  def home
  end
end
