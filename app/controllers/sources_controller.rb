# controller for Sources
class SourcesController < ApplicationController

  def index
    @sources = policy_scope(Source)
    @locale = params[:locale]
  end

  def chosen_sources
    @sources = Source.joins(:users).where(sources_users: { user_id: current_user.id })
    authorize Source
  end

  def update_sources_for_user
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

  def edit_sources_for_user
    authorize Source
    @sources = Source.all
    @user_sources = current_user.sources
    @locale = params[:locale]
  end
end
