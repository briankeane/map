require 'rubygems'
require 'rspec'
require 'pry-debugger'
require_relative '../set1.rb'

describe "Map" do

  describe "make_connection" do

    before(:each) do
      Map.clear_connections
    end

    it "should make a connection between 2 cities" do
      Map.make_connection("austin", "houston", 50)
      expect(Map::connections.size).to eq(1)
      expect(Map::connections[0]).to eq(["austin", "houston", 50])
    end
  end


  describe "find_all_routes" do

    before(:each) do
      Map.clear_connections
    end

    it "should return false if there are no connections" do
      Map.make_connection("austin","houston", 100)
      Map.make_connection("houston", "dallas", 100)
      Map.make_connection("boston", "cleveland", 3000)
      expect(Map.all_routes("cleveland", "austin")).to eq(false)
    end

    it "can return one really short route" do
      Map.make_connection("austin","houston", 100)
      expect(Map.all_routes("austin", "houston")).to eq([["austin", "houston"]])
    end


    it "can return one short route" do
      Map.make_connection("austin","houston", 100)
      Map.make_connection("houston", "dallas", 100)
      expect(Map.all_routes("austin", "dallas")).to eq([["austin", "houston", "dallas"]])
    end


    it "should return 1 route if available" do
      Map.make_connection("austin","houston", 100)
      Map.make_connection("houston", "dallas", 100)
      Map.make_connection("boston", "dallas", 1150)
      Map.make_connection("boston", "cleveland", 3000)
      expect(Map.all_routes("cleveland", "austin")).to eq([["cleveland","boston","dallas","houston","austin"]])
    end

    it "should return 2 routes if available" do
      Map.make_connection("austin","houston", 100)
      Map.make_connection("houston", "dallas", 100)
      Map.make_connection("boston", "dallas", 1150)
      Map.make_connection("boston", "cleveland", 3000)
      Map.make_connection("cleveland", "austin", 3400)
      expect(Map.all_routes("cleveland", "austin")).to eq([["cleveland","boston","dallas","houston","austin"]])
    end
  end
end
