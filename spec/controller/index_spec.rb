require 'spec_helper'
require 'sinatra/json'

describe "Index controller" do

	describe "GET '/cells'" do
		before do 
			5.times do |x|
				Cell.create(x_coordinate:x+1, y_coordinate:1, food_count:rand(1..10), mineral_count:rand(1..10))
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

	describe "GET '/cells/:x_coordinate/:y_coordinate'" do
		before do 
			@cell = Cell.create(x_coordinate:4, y_coordinate:1, food_count:5, mineral_count:8)
			get "/cells/#{@cell.x_coordinate}/#{@cell.y_coordinate}"
		end

		it "expected to return a cell with coordinate" do
			expect(last_response.body).to eq(Cell.where(:x_coordinate => @cell.x_coordinate, :y_coordinate => @cell.y_coordinate).to_json);
		end

		after do
			Cell.destroy_all
		end
	end
end