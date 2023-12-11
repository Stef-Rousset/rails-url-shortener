class SourcePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      Source.joins(:users).where(sources_users: { user_id: user.id })
    end
  end

  def choose_sources?
    user.sources.empty?
  end

  def update_sources_for_user?
    true
  end

  def edit_sources_for_user?
    user.sources.present?
  end
end
