class AddColumnRatingToDumpTable < ActiveRecord::Migration
  def change
    add_column :dumps, :rating, :integer
  end
end
