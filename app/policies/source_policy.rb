class SourcePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      Source.all
    end
  end

  def chosen_sources?
    user.sources.present?
  end

  def update_sources_for_user?
    true
  end

  def edit_sources_for_user?
    user.sources.present?
  end
end
