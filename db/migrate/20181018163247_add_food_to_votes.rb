class AddFoodToVotes < ActiveRecord::Migration[5.1]
  def change
    add_reference :votes, :food, foreign_key: true
  end
end
