require "json"

module Wumpus
  class Cave
    def self.dodecahedron
      self.new self.from_json("data/dodecahedron.json")
    end

    def self.from_json(filename)
      JSON.parse File.readlines(filename).join
    end

    def initialize(edges)
      @edges = edges
      # edges.each do |edge|
      #   self.room(edge[0]).connect(self.room edge[1])
      # end
    end

    def add_hazard(thing, count)
      raise NotImplementedError, "See lib/wumpus/cave.rb"
    end

    def random_room
      raise NotImplementedError, "See lib/wumpus/cave.rb"
    end

    def move(thing, from: raise, to: raise)
      raise NotImplementedError, "See lib/wumpus/cave.rb"
    end

    def room_with(thing)
      raise NotImplementedError, "See lib/wumpus/cave.rb"
    end

    def entrance
      raise NotImplementedError, "See lib/wumpus/cave.rb"
    end

    def room(number)
      neighbors = @edges.find_all { |e| e[0] == number || e[1] == number }.flatten.reject { |n| n == number }

      room = Room.new number
      neighbors.each { |n| room.connect(Room.new n) }
      room
    end
  end
end
