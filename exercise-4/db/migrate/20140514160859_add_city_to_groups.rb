class AddCityToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :city, :string
  end
end
