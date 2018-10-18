class AddColumnsToFood < ActiveRecord::Migration[5.1]
  def change
    add_column :foods, :discount, :integer
    add_column :foods, :view, :integer , default: 0
  end
end
