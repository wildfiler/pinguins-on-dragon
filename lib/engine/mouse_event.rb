module Engine
  class MouseEvent < Engine::Event
    attr_reader :mouse

    def initialize(type, object, mouse)
      super(type, object)
      @mouse = mouse
    end
  end
end
