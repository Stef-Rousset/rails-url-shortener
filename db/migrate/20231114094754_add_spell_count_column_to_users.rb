class AddSpellCountColumnToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :spell_count, :integer, null: false, default: 0
  end
end
