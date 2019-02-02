class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.integer :user_id
      t.integer :category, default: 0, null: false, limit: 1
      t.integer :genre, default: 0, null: false, limit: 1
      t.string :title
      t.string :image
      t.string :description

      t.timestamps
    end
  end
end
