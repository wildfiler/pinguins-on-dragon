module Engine
  class Game
    attr_gtk

    attr_reader :keyboard, :mouse

    def self.tick(klass, args)
      if args.state.tick_count.zero?
        $game = klass.new
        $game.init_observers
        $game.init(args)
      end
      $game.args = args
      $game&.tick(args)
    end

    def init(args)
    end

    def tick(args)
    end

    def tick_count
      state.tick_count
    end

    def init_observers
      @keyboard = Engine::KeyboardEvents.new
      @mouse = Engine::MouseEvents.new
    end

    def serialize
      {}
    end

    def insect
      "$<#{self.class.name}:#{self.object_id} #{serialize.map { |key, value| "#{key}=#{value}" }.join(" ")}>"
    end

    def to_s
      inspect
    end
  end
end
