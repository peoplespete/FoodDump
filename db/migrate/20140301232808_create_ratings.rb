class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.references :ingredient_id, index: true
      t.integer :rating

      t.timestamps
    end
  end
end
