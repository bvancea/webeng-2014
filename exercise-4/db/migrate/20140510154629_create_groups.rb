class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :description
      t.integer :owner_id

      t.timestamps
    end
  end
end
