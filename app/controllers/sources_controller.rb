# controller for Sources
class SourcesController < ApplicationController

  def index
    @sources = policy_scope(Source)
  end

  def choose_sources
    @sources = Source.all
    @locale = params[:locale]
    authorize Source
  end

  def update_sources_for_user
    authorize Source
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
    authorize Source
    @user_sources = policy_scope(Source)
    @locale = params[:locale]
  end
end
