module Pod
  class MouseEvent < Pod::Event
    attr_reader :mouse

    def initialize(type, object, mouse)
      super(type, object)
      @mouse = mouse
    end
  end
end
