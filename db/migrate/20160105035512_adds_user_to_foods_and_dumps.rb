class AddsUserToFoodsAndDumps < ActiveRecord::Migration
  def change
    add_column :foods, :user_id, :integer
    add_column :dumps, :user_id, :integer
  end
end
