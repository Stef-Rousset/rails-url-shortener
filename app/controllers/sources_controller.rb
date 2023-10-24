class SourcesController < ApplicationController
  before_action :authenticate_user!

  def index
    @sources = current_user.sources
  end

  def choose_sources
    @sources = Source.all
  end

  def add_sources_to_user
    ids = params[:source_ids].map(&:to_i)
    ids.map { |id| current_user.sources << Source.find(id) }
  end
end
