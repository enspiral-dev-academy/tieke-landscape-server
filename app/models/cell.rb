class Cell < ActiveRecord::Base

  def self.starting_cells
    Cell.destroy_all
    10.times do |y|
      10.times do |x|
        Cell.create(x: x+1, y: y+1, energy_expenditure: Math.sqrt( ((x+1)**2) + ((y+1)**2) ))
      end
    end
  end

  def self.assign_and_subtract_from_total_resources
    assign_random_food
    assign_random_minerals
  end

  def self.assign_random_food
    total_landscape_food = rand(1000..1500)
    total_landscape_food.times do
      cell = Cell.all.sample
      cell.food_count += 1
      cell.save!
    end
  end

  def self.assign_random_minerals
    total_landscape_minerals = rand(3000..4000)
    total_landscape_minerals.times do
      cell = Cell.all.sample
      cell.mineral_count += 1
      cell.save!
    end
  end

end
