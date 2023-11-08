# controller for Pages
class PagesController < ApplicationController
  def home
    @user = current_user if user_signed_in?
  end

  def about
  end

  def weather
  end
end
