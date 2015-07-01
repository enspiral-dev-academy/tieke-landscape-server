require 'sinatra/json'

 get '/cells' do
 	json Cell.all
 end
 # description: returns information about each cell
 # response:
 #    [
 #      {
 #        "x" : __,
 #        "y" : __,
 #        "food_count" : __,
 #        "mineral_count" : __
 #      },
 #      ...
 #    ]

 get '/cells/:x/:y' do
 	cell = Cell.find(params[:x], params[:y])
 	json cell
 end
 # description: returns information about cell with specified x and y coordinates
 # response:
 #    {
 #      "x" : __,
 #      "y" : __,
 #      "food_count" : __,
 #      "mineral_count" : __
 #    }

 post '/restart' do
end
 # description: resets landscape. destroys current cells, creates 100 new cells, each one with a random amount of minerals and food.
 # POST '/mine'
 # description: at cell with specified coords, decreases food + mineral amount proportionately with bot's mining_xp. Returns number of minerals mined as 'minerals_mined'. If no minerals left, nothing happens and minerals_mined returned is 0.
 # data:
 #    {
 #      "x" : __,
 #      "y" : __,
 #      "bot_mining_xp" : __
 #    }
 # response:
 #    {
 #      "minerals_mined" : __
 #    }
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
