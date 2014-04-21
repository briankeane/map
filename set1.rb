require 'pry-debugger'
module Map

  class Graph

    attr_reader :nodes

    def initialize
      @nodes = {}
    end

    def clear
      @nodes = {}
    end

    def addNode(value)
      @nodes[value] = Node.new(value)
    end

    def removeNode(value)
      @nodes.delete(value)
    end

    def addEdge(node_value_1, node_value_2, cost)
      @nodes[node_value_1].add_edge(node_value_2, cost)
      @nodes[node_value_2].add_edge(node_value_1, cost)
    end

    def removeEdge(node_value_1, node_value_2)
      @nodes[node_value1].delete_edge(node_value_2)
      @nodes[node_value2].delete_edge(node_value_1)
    end

    def findAllPaths(origin, destination, visited = [])

      solutions = []

      #grab the actual objects
      origin = @nodes[origin]
      destination = @nodes[destination]

      roads = origin.edges.dup
      visited = visited.dup

      # delete visited roads
      visited.each do |v|
        roads.delete(v)
      end

      # add current city to visited list
      visited << origin.value

      # if there are no roads left, return false
      if roads.size == 0
        return false
      end

      #otherwise, search each road
      roads.each do |city_string, distance|
        if city_string == destination.value
          solutions << (visited.dup << destination.value)
        else
          next_city_string = city_string
          result = self.findAllPaths(next_city_string, destination.value, visited)

          if result != false
            solutions.concat(result)
          end
        end
      end

      if solutions.size == 0
        return false
      else
        return solutions
      end
    end

    def find_shortest_route(origin, destination)
      all_routes = self.findAllPaths(origin, destination)

      if all_routes == false
        return false
      else

        distances = all_routes.map do |route|

          sum = 0

          limit = (route.size - 2)

          for i in (0..limit)

            sum += @nodes[route[i]].edges[route[i+1]]

          end

          sum
        end

        index = distances.find_index(distances.min)
        return all_routes[index]
      end
    end
  end

  class Node

    attr_accessor :edges, :value
    def initialize(value)
      @value = value
      @edges = {} # hash to map connected Nodes to the associated cost
    end

    def add_edge(node_value, cost)
      @edges[node_value] = cost
    end

    def delete_edge(node_value)
      @edges.delete(node_value)
    end
  end
end
