require 'sinatra/json'

get '/cells' do
	json Cell.all.sort
end

get '/cells/:x/:y' do
	cell = Cell.where(:x => params[:x], :y => params[:y])
	json cell
end

post '/restart' do
	Cell.starting_cells
	Cell.assign_and_subtract_from_total_resources
	json Cell.all
end

post '/harvest' do
	cell = Cell.find_by(x: params[:x].to_i, y: params[:y].to_i)
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
		cell: cell,
		food_harvested: @food_harvested
	}.to_json
end

 post '/mine' do
	cell = Cell.find_by(x: params[:x].to_i, y: params[:y].to_i)
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
		cell: cell,
		minerals_mined: @minerals_mined
	}.to_json
 end

