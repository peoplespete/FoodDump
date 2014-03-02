class ChangeColumnNameRating < ActiveRecord::Migration
  def change
    rename_column :ratings, :ingredient_id_id, :ingredient_id

  end
end
