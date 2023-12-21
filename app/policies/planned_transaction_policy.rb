class PlannedTransactionPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      user.admin? ? scope.all : scope.where(account_id: user.accounts.map(&:id))
    end
  end

  def new?
    user.accounts.present? # access to new only if current_user has an account
  end

  def create?
    true
  end

  def edit?
    find_user == user
  end

  def update?
    find_user == user
  end

  def destroy?
    find_user == user
  end

  private

  def find_user
    User.find(Account.find(record.account_id).user_id)
  end
end
