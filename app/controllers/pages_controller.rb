# controller for Pages
class PagesController < ApplicationController
  skip_before_action :authenticate_user!, except: %i[weather spell_checker spell_checked]

  def home
    @user = current_user if user_signed_in?
  end

  def about
  end

  def weather
  end

  def spell_checker
    @locale = params[:locale]
  end

  def spell_checked
    if current_user.spell_count >= 5
      flash.now[:alert] = t(:five_limit)
      render :spell_checker, status: :unprocessable_entity
    else
      @word = params[:search].split(' ')[0] # only get the first word if multiple words are entered
      @language_for_word = params[:language]
      @locale = params[:locale]
      @response = HandleOpenai.new(@word, @language_for_word, @locale).get_word_checked
      if !@response.include?("Une erreur s'est produite") || !@response.include?('An error occured')
        current_user.spell_count += 1
        current_user.save
      end
      respond_to do |format|
        format.turbo_stream
      end
    end
  end
end
