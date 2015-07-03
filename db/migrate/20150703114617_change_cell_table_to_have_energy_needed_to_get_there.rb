class ChangeCellTableToHaveEnergyNeededToGetThere < ActiveRecord::Migration
  def change
    add_column :cells, :energy_expenditure, :decimal, precision: 4, scale: 2, default: 0
  end
end
