class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.decimal :balance, precision: 11, scale: 2, default: 0.0
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
