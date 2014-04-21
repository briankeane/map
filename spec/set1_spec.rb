require 'rubygems'
require 'rspec'
require 'pry-debugger'
require_relative '../set1.rb'

describe "Map" do

  describe "make_connection" do

    before(:each) do
      @graph = Map::Graph.new
    end

    it "should make a connection between 2 cities" do
      @graph.addNode("austin")
      @graph.addNode("houston")
      @graph.addEdge("austin", "houston", 50)
      expect(@graph.nodes.size).to eq(2)
      expect(@graph.nodes["austin"].edges["houston"]).to eq(50)
    end
  end


  describe "find_all_routes" do

    before(:each) do
      @graph = Map::Graph.new
    end

    it "should return false if there are no connections" do
      @graph.addNode("austin")
      @graph.addNode("houston")
      @graph.addNode("boston")
      @graph.addNode("cleveland")
      @graph.addNode("dallas")
      @graph.addEdge("austin","houston", 100)
      @graph.addEdge("houston", "dallas", 100)
      @graph.addEdge("boston", "cleveland", 3000)
      expect(@graph.findAllPaths("cleveland", "austin")).to eq(false)
    end

    it "can return one really short route" do
      @graph.addNode("austin")
      @graph.addNode("houston")
      @graph.addEdge("austin","houston", 100)
      expect(@graph.findAllPaths("austin", "houston")).to eq([["austin", "houston"]])
    end


    it "can return one short route" do
      @graph.addNode("austin")
      @graph.addNode("houston")
      @graph.addNode("dallas")
      @graph.addEdge("austin","houston", 100)
      @graph.addEdge("houston", "dallas", 100)
      expect(@graph.findAllPaths("austin", "dallas")).to eq([["austin", "houston", "dallas"]])
    end


    it "should return 1 route if available" do
      @graph.addNode("austin")
      @graph.addNode("houston")
      @graph.addNode("boston")
      @graph.addNode("cleveland")
      @graph.addNode("dallas")
      @graph.addEdge("austin","houston", 100)
      @graph.addEdge("houston", "dallas", 100)
      @graph.addEdge("boston", "dallas", 1150)
      @graph.addEdge("boston", "cleveland", 3000)
      expect(@graph.findAllPaths("cleveland", "austin")).to eq([["cleveland","boston","dallas","houston","austin"]])
    end

    it "should return 2 short routes" do
      @graph.addNode("austin")
      @graph.addNode("houston")
      @graph.addNode("dallas")
      @graph.addNode("okc")
      @graph.addEdge("austin","houston", 100)
      @graph.addEdge("austin", "dallas", 100)
      @graph.addEdge("houston", "okc", 3000)
      @graph.addEdge("dallas", "okc", 3000)
      expect(@graph.findAllPaths("austin","okc")).to eq([["austin", "houston", "okc"], ["austin", "dallas", "okc"]])
    end

    it "should return 2 routes if available" do
      @graph.addNode("austin")
      @graph.addNode("houston")
      @graph.addNode("dallas")
      @graph.addNode("boston")
      @graph.addNode("cleveland")
      @graph.addEdge("austin","houston", 100)
      @graph.addEdge("houston", "dallas", 100)
      @graph.addEdge("boston", "dallas", 1150)
      @graph.addEdge("boston", "cleveland", 3000)
      @graph.addEdge("cleveland", "austin", 3400)
      expect(@graph.findAllPaths("cleveland", "austin")).to eq([["cleveland","boston","dallas","houston","austin"], ["cleveland", "austin"]])
    end

    it "can return a shitload of routes if they exist (shitload = 6)" do
      @graph.addNode("dallas")
      @graph.addNode("okc")
      @graph.addNode("texarkana")
      @graph.addNode("austin")
      @graph.addNode("san antonio")
      @graph.addNode("houston")
      @graph.addNode("college station")
      @graph.addEdge("dallas","okc", 206)
      @graph.addEdge("dallas","texarkana", 100)
      @graph.addEdge("austin", "dallas", 195)
      @graph.addEdge("san antonio", "austin", 80)
      @graph.addEdge("san antonio", "houston", 197)
      @graph.addEdge("houston", "college station", 80)
      @graph.addEdge("college station", "dallas", 181)
      @graph.addEdge("houston", "texarkana", 290)
      @graph.addEdge("austin", "college station", 106)
      expect(@graph.findAllPaths("san antonio","dallas").size).to eq(6)
    end

    it "can return the shortest route" do
      @graph.addNode("dallas")
      @graph.addNode("okc")
      @graph.addNode("texarkana")
      @graph.addNode("austin")
      @graph.addNode("houston")
      @graph.addNode("san antonio")
      @graph.addNode("houston")
      @graph.addNode("college station")
      @graph.addEdge("dallas","okc", 206)
      @graph.addEdge("dallas","texarkana", 100)
      @graph.addEdge("austin", "dallas", 195)
      @graph.addEdge("san antonio", "austin", 80)
      @graph.addEdge("san antonio", "houston", 197)
      @graph.addEdge("houston", "college station", 80)
      @graph.addEdge("college station", "dallas", 181)
      @graph.addEdge("houston", "texarkana", 290)
      @graph.addEdge("austin", "college station", 106)
      expect(@graph.find_shortest_route("austin", "college station")).to eq(["austin", "college station"])
      expect(@graph.find_shortest_route("san antonio", "okc")).to eq(["san antonio", "austin", "dallas", "okc"])
      expect(@graph.find_shortest_route("houston", "okc")).to eq(["houston","college station","dallas", "okc"])
    end

    it "returns false if no route exists" do
      @graph.addNode("tulsa")
      @graph.addNode("dallas")
      @graph.addNode("okc")
      @graph.addNode("texarkana")
      @graph.addNode("austin")
      @graph.addNode("houston")
      @graph.addNode("san antonio")
      @graph.addNode("houston")
      @graph.addNode("college station")
      @graph.addEdge("tulsa","okc", 299)
      @graph.addEdge("dallas","texarkana", 100)
      @graph.addEdge("austin", "dallas", 195)
      @graph.addEdge("san antonio", "austin", 80)
      @graph.addEdge("san antonio", "houston", 197)
      @graph.addEdge("houston", "college station", 80)
      @graph.addEdge("college station", "dallas", 181)
      @graph.addEdge("houston", "texarkana", 290)
      @graph.addEdge("austin", "college station", 106)
      expect(@graph.find_shortest_route("austin", "okc")).to eq(false)
    end
  end
end
