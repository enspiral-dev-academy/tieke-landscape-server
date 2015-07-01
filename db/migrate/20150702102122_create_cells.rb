class CreateCells < ActiveRecord::Migration
  def change
  	create_table :cells do |t|
  		t.string :food_count
 		t.string :mineral_count
  		t.string :x_coordinate
  		t.string :y_coordinate
  		t.timestamps null:false
  	end
  end
end
