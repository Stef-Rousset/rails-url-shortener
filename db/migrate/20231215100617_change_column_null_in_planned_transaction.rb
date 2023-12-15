class ChangeColumnNullInPlannedTransaction < ActiveRecord::Migration[7.0]
  def change
    change_column_null :planned_transactions, :category_id, true
  end
end
