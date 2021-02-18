module Engine
  class Sprite
    attr_sprite

    include Engine::AttributeAssignment

    attr_reader :name

    def initialize(attributes = {})
      attributes.each do |name, value|
        instance_variable_set("@#{name}", value)
      end
    end

    def path
      if name
        @path ||= "sprites/#{name}.png"
      else
        super
      end
    end
  end
end
