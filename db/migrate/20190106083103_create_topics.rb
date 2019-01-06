class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.integer :user_id
      t.integer :category
      t.string :title
      t.string :topic_image
      t.string :description

      t.timestamps
    end
  end
end
