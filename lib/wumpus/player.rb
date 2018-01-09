module Wumpus
  class Player
    def initialize
      @sensed = Hash.new
      @encountered = Hash.new
      @actions = Hash.new
    end

    attr_reader :room

    def sense(thing, &callback)
      @sensed[thing] = callback
    end

    def encounter(thing, &callback)
      @encountered[thing] = callback
    end

    def action(thing, &callback)
      @actions[thing] = callback
    end

    def enter(room)
      @room = room
      return if room.empty?

      # FIXME: If there's a hazard that doesn't kill or remove the player from
      # the room, this won't work
      @encountered.select { |k, _| room.has? k }.values.first.call
    end

    def explore_room
      @sensed.values.map &:call
    end

    def act(action, destination)
      @actions[action].call destination
    end
  end
end
