class AddUniquenessToNameAndUrlInSources < ActiveRecord::Migration[7.0]
  def change
    add_index :sources, :name, unique: true
    add_index :sources, :url, unique: true
  end
end
