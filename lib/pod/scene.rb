module Pod
  class Scene
    attr_gtk

    attr_reader :keyboard, :mouse, :next_scene

    def initialize(**attributes)
      @keyboard = Pod::EventsDispatcher.new(attributes[:keyboard] || $game.keyboard)
      @mouse = Pod::EventsDispatcher.new(attributes[:mouse] || $game.mouse)
    end

    def before_load
      keyboard.start
      mouse.start
    end

    def after_load
    end

    def load
    end

    def before_unload
      keyboard.stop
      mouse.stop
    end

    def after_unload
    end

    def unload
    end

    def tick
    end
  end
end
