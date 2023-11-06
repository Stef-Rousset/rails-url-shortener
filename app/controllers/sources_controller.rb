# controller for Sources
class SourcesController < ApplicationController
  before_action :authenticate_user!

  def index
    @sources = current_user.sources
  end

  def choose_sources
    @sources = Source.all
  end

  def add_sources_to_user
    current_user.sources.delete_all
    if params[:source_ids].present?
      ids = params[:source_ids].map(&:to_i)
      ids.map { |id| current_user.sources << Source.find(id) }
      redirect_to sources_path
    else
      redirect_to choose_sources_path
    end
  end

  def edit_sources_for_user
    @sources = Source.all
    @user_sources = current_user.sources
  end
end
