class CreateCells < ActiveRecord::Migration
  def change
  	create_table :cells do |t|
  		t.integer :food_count
 			t.integer :mineral_count
  		t.integer :x
  		t.integer :y
  		t.timestamps null:false
  	end
  end
end
