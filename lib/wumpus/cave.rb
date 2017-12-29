require "json"

module Wumpus
  class Cave
    def self.dodecahedron
      self.new self.from_json("data/dodecahedron.json")
    end

    def self.from_json(filename)
      JSON.parse File.read(filename)
    end

    def initialize(edges)
      @edges = edges
      @rooms = []

      (1..20).each { |i| @rooms << Room.new(i) }

      edges.each do |edge|
        room1 = @rooms.find { |r| r.number == edge[0] }
        room2 = @rooms.find { |r| r.number == edge[1] }
        room1.connect room2
      end
    end

    def add_hazard(thing, count)
      (1..count).each { self.random_room.add thing }
    end

    def random_room
      @rooms.sample
    end

    def move(thing, from: raise, to: raise)
      from.remove thing
      to.add thing
    end

    def room_with(thing)
      @rooms.find { |r| r.has? thing }
    end

    def entrance
      @rooms.find &:safe?
    end

    def room(number)
      @rooms.find { |r| r.number == number }
    end
  end
end
