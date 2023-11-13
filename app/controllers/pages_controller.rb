# controller for Pages
class PagesController < ApplicationController
  before_action :authenticate_user!, only: %i[weather spell_checker]

  def home
    @user = current_user if user_signed_in?
  end

  def about
  end

  def weather
  end

  def spell_checker
  end

  def spell_checked
    @word = params[:search]
    @response = HandleOpenai.new(@word).get_word_checked
    respond_to do |format|
      format.turbo_stream
    end
  end
end
