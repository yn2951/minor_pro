class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :image
      t.string :introduce

      t.timestamps
    end
  end
end
