class TransactionPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  # new? returns create? in ApplicationPolicy

  def create?
    true
  end

  def edit?
    find_user == user && !record.checked # can't edit a checked transaction
  end

  def update?
    find_user == user
  end

  def update_checked?
    find_user == user
  end

  def destroy?
    find_user == user
  end

  private

  def find_user
    User.find(record.account.user_id)
  end
end
