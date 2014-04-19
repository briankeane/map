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

    it "should return 2 short routes" do
      Map.make_connection("austin","houston", 100)
      Map.make_connection("austin", "dallas", 100)
      Map.make_connection("houston", "okc", 3000)
      Map.make_connection("dallas", "okc", 3000)
      expect(Map.all_routes("austin","okc")).to eq([["austin", "houston", "okc"], ["austin", "dallas", "okc"]])
    end

    it "should return 2 routes if available" do
      Map.make_connection("austin","houston", 100)
      Map.make_connection("houston", "dallas", 100)
      Map.make_connection("boston", "dallas", 1150)
      Map.make_connection("boston", "cleveland", 3000)
      Map.make_connection("cleveland", "austin", 3400)
      expect(Map.all_routes("cleveland", "austin")).to eq([["cleveland","boston","dallas","houston","austin"], ["cleveland", "austin"]])
    end

    it "can return a shitload of routes if they exist (shitload = 6)" do
      Map.make_connection("dallas","okc", 206)
      Map.make_connection("dallas","texarkana", 100)
      Map.make_connection("austin", "dallas", 195)
      Map.make_connection("san antonio", "austin", 80)
      Map.make_connection("san antonio", "houston", 197)
      Map.make_connection("houston", "college station", 80)
      Map.make_connection("college station", "dallas", 181)
      Map.make_connection("houston", "texarkana", 290)
      Map.make_connection("austin", "college station", 106)
      expect(Map.all_routes("san antonio","dallas").size).to eq(6)
    end

    it "can return the shortest route" do
      Map.make_connection("dallas","okc", 206)
      Map.make_connection("dallas","texarkana", 100)
      Map.make_connection("austin", "dallas", 195)
      Map.make_connection("san antonio", "austin", 80)
      Map.make_connection("san antonio", "houston", 197)
      Map.make_connection("houston", "college station", 80)
      Map.make_connection("college station", "dallas", 181)
      Map.make_connection("houston", "texarkana", 290)
      Map.make_connection("austin", "college station", 106)
      expect(Map.shortest_route("austin", "college station")).to eq(["austin", "college station"])
      expect(Map.shortest_route("san antonio", "okc")).to eq(["san antonio", "austin", "dallas", "okc"])
      expect(Map.shortest_route("houston", "okc")).to eq(["houston","college station","dallas", "okc"])
    end

    it "returns false if no route exists" do
      Map.make_connection("tulsa","okc", 299)
      Map.make_connection("dallas","texarkana", 100)
      Map.make_connection("austin", "dallas", 195)
      Map.make_connection("san antonio", "austin", 80)
      Map.make_connection("san antonio", "houston", 197)
      Map.make_connection("houston", "college station", 80)
      Map.make_connection("college station", "dallas", 181)
      Map.make_connection("houston", "texarkana", 290)
      Map.make_connection("austin", "college station", 106)
      expect(Map.shortest_route("austin", "okc")).to eq(false)
    end
  end
end
