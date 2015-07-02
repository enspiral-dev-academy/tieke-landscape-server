require 'spec_helper'
require 'sinatra/json'

describe "Index controller" do

	describe "GET '/cells'" do
		before do
			5.times do |x|
				Cell.create(x:x+1, y:1, food_count:rand(1..10), mineral_count:rand(1..10))
			end
			get '/cells'
		end

		it "expected to return all the cell" do

			expect(last_response.body).to eq(Cell.all.to_json)
		end

		after do
			Cell.destroy_all
		end
	end

	describe "GET '/cells/:x/:y'" do
		before do
			@cell = Cell.create(x:4, y:1, food_count:5, mineral_count:8)
			get "/cells/#{@cell.x}/#{@cell.y}"
		end

		it "expected to return a cell with coordinate" do
			expect(last_response.body).to eq(Cell.where(:x => @cell.x, :y => @cell.y).to_json);
		end

		after do
			Cell.destroy_all
		end
	end

	describe "post '/harvest'" do

		let (:cell) { Cell.create(x:4, y:1, food_count: 2, mineral_count:8) }

		context "if not enough food in the cell" do
			before do
				@cell = cell
				params = {
					x: @cell.x,
					y: @cell.y,
					bot_harvesting_xp: 5
				}
				post "/harvest", params
				@cell = Cell.find(@cell.id)
			end

			it "returns the amount of food in the cell" do
				expect(last_response.body).to eq({"cell" => @cell, food_harvested: 2}.to_json)
			end

			it "it sets cells food_count to 0" do
				expect(@cell.food_count).to eq(0)
			end
		end

		context "if enough food in cell" do
			before do
				@cell = Cell.create(x:4, y:1, food_count: 5, mineral_count:8)
				params = {
					x: @cell.x,
					y: @cell.y,
					bot_harvesting_xp: 2}
				post "/harvest", params
				@cell = Cell.find(@cell.id)
			end
			it "returns food_harvested exactly equal to bot's harvest_xp, as json" do
				expect(last_response.body).to eq({"cell" => @cell, food_harvested: 2}.to_json)
			end
			it "removes food_harvested amount of food from the cell" do
				expect(@cell.food_count).to eq(3)
			end
		end

		after do
			Cell.destroy_all
		end

	end

		describe "post '/mine'" do

		let (:cell) { Cell.create(x:4, y:1, food_count: 2, mineral_count:4) }

		context "if not enough minerals in the cell" do
			before do
				@cell = cell
				params = {
					x: @cell.x,
					y: @cell.y,
					bot_mining_xp: 5
				}
				post "/mine", params
				@cell = Cell.find(@cell.id)
			end

			it "returns the amount of minerals in the cell" do
				expect(last_response.body).to eq({"cell" => @cell, minerals_mined: 4}.to_json)
			end

			it "it sets cells mineral_count to 0" do
				expect(@cell.mineral_count).to eq(0)
			end
		end

		context "if enough minerals in cell" do
			before do
				@cell = Cell.create(x: 4, y: 1, food_count: 5, mineral_count: 8)
				params = {
					x: @cell.x,
					y: @cell.y,
					bot_mining_xp: 2}
				post "/mine", params
				@cell = Cell.find(@cell.id)
			end
			it "returns minerals_mined exactly equal to bot_mining_xp, as json" do
				expect(last_response.body).to eq({"cell" => @cell, minerals_mined: 2}.to_json)
			end
			it "removes minerals_mined amount of minerals from the cell" do
				expect(@cell.mineral_count).to eq(6)
			end
			it "removes food_harvested amount of food from the cell" do
				expect(@cell.food_count).to eq(3)
			end
		end

		after do
			Cell.destroy_all
		end

	end
end