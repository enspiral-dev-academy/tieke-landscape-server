require 'sinatra/json'

get '/cells' do
	json Cell.all
end

get '/cells/:x_coordinate/:y_coordinate' do
	cell = Cell.where(:x_coordinate => params[:x_coordinate], :y_coordinate => params[:y_coordinate])
	json cell
end

post '/restart' do
	Cell.destroy_all
	x = 1
	y = 1

	10.times do |y|
		10.times do |x|
			Cell.create(x_coordinate:x+1, y_coordinate:y+1, food_count:rand(1..10), mineral_count:rand(1..10))
		end
	end	
end

post '/harvest' do
	cell = Cell.find_by(x_coordinate: params[:x_coordinate].to_i, y_coordinate: params[:y_coordinate].to_i)
	bot_harvesting_xp = params[:bot_harvesting_xp].to_i
	if cell.food_count < bot_harvesting_xp
		@food_harvested = cell.food_count
		cell.food_count = 0
	else
		@food_harvested = bot_harvesting_xp
		cell.food_count -= bot_harvesting_xp 
	end
		cell.save
	{
    food_harvested: @food_harvested
	}.to_json	
end

 post '/mine' do
 	cell = Cell.find_by(x_coordinate: params[:x_coordinate].to_i, y_coordinate: params[:y_coordinate].to_i)
	bot_mining_xp = params[:bot_mining_xp].to_i
	if cell.mineral_count < bot_mining_xp
		@minerals_mined = cell.mineral_count 
		cell.mineral_count = 0
	else
		@minerals_mined = bot_mining_xp
		cell.mineral_count -= bot_mining_xp
	end

	if cell.food_count < bot_mining_xp
		cell.food_count =0
	else
		cell.food_count -= bot_mining_xp 
	end
		cell.save
	{
    minerals_mined: @minerals_mined
	}.to_json	

 end

