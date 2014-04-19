require 'pry-debugger'
module Map

  @@connections = []

  def self.clear_connections
    @@connections = []
    @@flag = true
  end

  def self.make_connection(city1, city2, miles)
    @@connections << [city1, city2, miles]
  end

  def self.connections
    @@connections
  end

  def self.all_routes(origin, destination, visited=[])

    solutions = []

    # copy roads and visited arrays so they're separate for each layer
    roads = @@connections.dup
    visited = visited.dup

    visited.each do |v|
      roads.delete_if { |x| x.include?(v) }
    end

    ## add the current city to visited list
    visited << origin

    #now filter for roads containing origin city
    roads.delete_if { |x| x.include?(origin) == false }

    #Now roads contains all untravelled roads out of town

    # if there are no roads left, return false
    if roads.size == 0
      return false
    end
    # otherwise search each road
    roads.each do |x|

      #if the next step includes the destination
      if x.include?(destination)
        #Store the path in the solutions array
        # visited << destination  #thinking this is fucking it up
        solutions << (visited.dup << destination)
      #otherwise, send out another searcher
      else
        # set next city
        if x[0] == origin
          next_city = x[1]
        else
          next_city = x[0]
        end


        result = self.all_routes(next_city, destination, visited)

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

  def self.shortest_route(origin, destination)
    all_routes = self.all_routes(origin, destination)
    if all_routes == false
      return false
    else

      # map array with the total mileages
      distances = all_routes.map do |route|

        sum = 0

        # simulate a javascript for loop
        limit = (route.size - 2)
        for i in (0..limit)

          distance_array = []
          distance_array = @@connections.find { |c| (c[0] == route[i] || c[0] == route[i+1]) &&
                                                (c[1] == route[i] || c[1] == route[i+1]) }

          sum += distance_array[2]
        end

        sum
      end

      index = distances.find_index(distances.min)
      return all_routes[index]
    end
  end



end
