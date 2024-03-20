class SourcePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      Source.all
    end
  end

  def chosen?
    user.sources.present?
  end

  def update?
    true
  end

  def edit?
    user.sources.present?
  end
end
