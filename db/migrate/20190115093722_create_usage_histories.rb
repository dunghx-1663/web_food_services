class CreateUsageHistories < ActiveRecord::Migration[5.1]
  def change
    create_table :usage_histories do |t|
      t.integer :amount
      t.datetime :used_date
      t.integer :settlement_code

      t.timestamps
    end
  end
end
