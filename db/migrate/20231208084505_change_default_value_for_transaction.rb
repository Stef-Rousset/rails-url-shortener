class ChangeDefaultValueForTransaction < ActiveRecord::Migration[7.0]
  def change
    change_column_default :transactions, :amount, from: 0.01, to: 0.0
  end
end
