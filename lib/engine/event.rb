module Engine
  class Event
    attr_reader :type, :object

    def initialize(type, object)
      @type = type
      @object = object
    end

    def serialize
      {
        type: type,
        object: object,
      }
    end

    def to_s
      "#<#{self.class.name}:#{object_id} type=#{type}>"
    end
  end
end
