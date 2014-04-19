require 'pry-debugger'
module Map

  @@connections = []

  def self.make_connection(city1, city2, miles)
    @@connections << [city1, city2, miles]
  end

  def self.connections
    @@connections
  end

  def self.all_routes(origin, destination, visited=[])

    solutions = []

    # filter out roads already visited
    roads = @@connections

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
    binding.pry
    # otherwise search each road
    roads.each do |x|

      #if the next step includes the destination
      if x.include?(destination)
        #Store the path in the solutions array
        visited << destination
        solutions << visited
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
end
