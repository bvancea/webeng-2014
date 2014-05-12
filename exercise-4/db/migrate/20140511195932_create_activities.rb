class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :name
      t.string :description
      t.string :location
      t.float :duration
      t.datetime :start_date
      t.string :image_url
      t.boolean :definitive
      t.integer :votes
      t.integer :group_id

      t.timestamps
    end
  end
end
