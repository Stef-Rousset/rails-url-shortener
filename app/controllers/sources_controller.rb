# controller for Sources
class SourcesController < ApplicationController

  def index
    @sources = policy_scope(Source)
    @locale = params[:locale]
  end

  def chosen
    @sources = Source.joins(:users).where(sources_users: { user_id: current_user.id })
    authorize Source
  end

  #update sources for user in join table
  def update
    authorize Source
    current_user.sources.delete_all
    if params[:source_ids].present?
      ids = params[:source_ids].map(&:to_i)
      ids.map { |id| current_user.sources << Source.find(id) }
      redirect_to chosen_sources_path
    else
      redirect_to sources_path
    end
  end

  #edit sources for user
  def edit
    authorize Source
    @sources = Source.all
    @user_sources = current_user.sources
    @locale = params[:locale]
  end
end
