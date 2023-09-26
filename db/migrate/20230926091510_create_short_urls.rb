class CreateShortUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :short_urls do |t|
      t.string :long_url, null: false
      t.string :tiny_url, null: false, index: { unique: true, name: 'unique_tiny_urls' }
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
