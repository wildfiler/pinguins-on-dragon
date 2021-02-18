module Engine
  class KeyboardEvent < Engine::Event
    attr_reader :keyboard

    def initialize(type, object, keyboard)
      super(type, object)
      @keyboard = keyboard
    end
  end
end
