require 'rubygems'
require 'rspec'
require 'pry-debugger'
require_relative '../set1.rb'

describe "Map" do
  describe "make_connection" do
    it "should make a connection between 2 cities" do
      Map.make_connection("Austin", "Houston", 50)
      expect(Map::connections.size).to eq(1)
      expect(Map::connections[0]).to eq(["Austin", "Houston", 50])
    end
  end


  describe "find_all_routes" do
    it "should return false if there are no connections" do
      Map.make_connection("austin","houston", 100)
      Map.make_connection("houston", "dallas", 100)
      Map.make_connection("boston", "cleveland", 3000)
      expect(Map.all_routes("cleveland", "austin")).to eq(false)
    end

    it "should return 1 route if available" do
      Map.make_connection("austin","houston", 100)
      Map.make_connection("houston", "dallas", 100)
      Map.make_connection("boston", "dallas", 1150)
      Map.make_connection("boston", "cleveland", 3000)
      expect(Map.all_routes("cleveland", "austin")).to eq([])


    end
  end
end
