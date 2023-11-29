class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :payee, null: false
      t.decimal :amount, precision: 11, scale: 2, default: 0.01
      t.date :date, null: false
      t.integer :type, null: false
      t.text :description
      t.boolean :checked, default: false
      t.references :account, null: false, foreign_key: true
      t.references :category, null: true, foreign_key: true

      t.timestamps
    end
  end
end
