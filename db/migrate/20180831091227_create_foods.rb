class CreateFoods < ActiveRecord::Migration[5.1]
  def change
    create_table :foods do |t|
      t.string :name
      t.string :img_url
      t.string :description
      t.float :price
      t.float :rating_avg

      t.timestamps
    end
  end
end
