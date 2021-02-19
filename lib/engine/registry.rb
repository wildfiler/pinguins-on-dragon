module Engine
  class Registry
    attr_reader :name

    def initialize(name)
      @name = name
    end

    def add(name, object)
      registry[name] = object
    end

    def remove(name)
      registry.delete(name)
    end

    def find(name)
      registry[name]
    end

    def serialize
      registry
    end

    def inspect
      "#<#{self.class.name}:#{object_id} name=\"#{name}\" registry=#{registry.inspect} >"
    end

    def to_s
      "#<#{self.class.name} name=\"#{name}\" registry=#{registry} >"
    end

    private

    def registry
      @registry ||= {}
    end
  end
end
