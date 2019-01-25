class CreateCounters < ActiveRecord::Migration[5.2]
  def change
    create_table :counters do |t|
      t.integer :topic_id
      t.integer :good_count, default: 0, null: false, limit: 1
      t.integer :minor_count, default: 0, null: false, limit: 1
      t.integer :bookmark_count, default: 0, null: false, limit: 1
      t.integer :comment_count, default: 0, null: false, limit: 1
      t.integer :variation, default: 0, null: false, limit: 1

      t.timestamps
    end
  end
end
