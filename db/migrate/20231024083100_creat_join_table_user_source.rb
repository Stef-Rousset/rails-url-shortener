class CreatJoinTableUserSource < ActiveRecord::Migration[7.0]
  def change
    create_join_table :users, :sources do |t|
      t.index [:user_id, :source_id], unique: true
    end
  end
end
