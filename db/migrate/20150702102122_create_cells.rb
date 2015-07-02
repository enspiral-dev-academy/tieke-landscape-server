class CreateCells < ActiveRecord::Migration
  def change
  	create_table :cells do |t|
  		t.integer :food_count
 			t.integer :mineral_count
  		t.integer :x_coordinate
  		t.integer :y_coordinate
  		t.timestamps null:false
  	end
  end
end
