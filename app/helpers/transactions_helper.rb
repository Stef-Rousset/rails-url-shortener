module TransactionsHelper

  def categories_for_form(account)
    Category.where(user_id: nil)
            .or(Category.where(user_id: account.user_id))
            .map{ |cate| [cate.name, cate.id] }.push([t(:none), nil])
            .reverse! # reverse to get "None" first
  end

  def transaction_type_translated
    Transaction.transaction_types.keys.map{ |key| [t("activerecord.attributes.transaction.transaction_type.#{key}"), key] }
  end

end
