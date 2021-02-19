module Engine
  class Game
    attr_gtk

    attr_reader :scene

    def self.tick(klass, args)
      if args.state.tick_count.zero?
        $game = klass.new
        $game.args = args
        $game.init
      end

      if $game
        $game.args = args
        $game.perform_tick(args)
      end
    end

    def init
    end

    def tick
      if scene
        scene.args = args
        scene.tick
      end
    end

    def perform_tick(args)
      keyboard.tick(args)
      mouse.tick(args)

      tick

      switch_scene
    end

    def switch_scene
      return unless scene

      next_scene = scene.next_scene
      if next_scene
        self.scene = next_scene
      end
    end

    def scene=(new_scene)
      if scene
        scene.before_unload
        scene.unload
        scene.after_unload
      end

      @scene = new_scene

      scene.args = args

      scene.before_load
      scene.load
      scene.after_load
    end

    def tick_count
      state.tick_count
    end

    def keyboard
      @keyboard ||= Engine::KeyboardEvents.new
    end

    def mouse
      @mouse ||= Engine::MouseEvents.new
    end

    def spritesheets
      @spritesheets ||= Engine::Registry.new(:spritesheets)
    end

    def serialize
      {
        scene: scene,
        keyboard: keyboard,
        mouse: mouse,
      }
    end

    def inspect
      "#<#{self.class.name}:#{self.object_id} #{serialize.map { |key, value| "#{key}=#{value.inspect}" }.join(" ")}>"
    end

    def to_s
      inpect
    end
  end
end
