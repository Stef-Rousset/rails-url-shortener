class CreatePlannedTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :planned_transactions do |t|
      t.string :payee, null: false
      t.decimal :amount, precision: 11, scale: 2, default: 0.0
      t.date :start_date, null: false
      t.text :description
      t.integer :transaction_type, null: false
      t.integer :every, null: false
      t.references :account, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
