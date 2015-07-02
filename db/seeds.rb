Cell.destroy_all
x = 1
y = 1

10.times do |y|
	10.times do |x|
		Cell.create(x:x+1, y:y+1, food_count:rand(1..10), mineral_count:rand(1..10))
	end
end	
