class ChangeCellStartingResourcesToBeNotNil < ActiveRecord::Migration
  def change
    change_column_default(:cells, :food_count, 0)
    change_column_default(:cells, :mineral_count, 0)
  end
end
