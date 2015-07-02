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
	
end
# description: at given coords, decreases food amount proportionately with bot's harvesting_xp. returns number of food harvested as 'food_harvested'. if no food left, nothing happens and food-harvested is 0.
# data:
#     {
#       "x" : __,
#       "y" : __,
#       "bot_harvesting_xp" : __
#     }
# - response:
#     {
#       "food_harvested" : __
#     }
 post '/mine' do
 end
 # description: at cell with specified coords, decreases food + mineral amount proportionately with bot's mining_xp. Returns number of minerals mined as 'minerals_mined'. If no minerals left, nothing happens and minerals_mined returned is 0.
 # data:
 #    {
 #      "x_coordinate" : "__",
 #      "y_coordinate" : "__",
 #      "bot_mining_xp" : __
 #    }
 # response:
 #    {
 #      "minerals_mined" : __
 #    }
