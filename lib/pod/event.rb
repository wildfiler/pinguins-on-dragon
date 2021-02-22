module Pod
  class Event
    attr_reader :type, :object, :origin_event

    def initialize(type, object, origin_event: nil)
      @type = type
      @object = object
      @origin_event = origin_event
    end

    def serialize
      {
        type: type,
        object: object,
        origin_event: origin_event,
      }
    end

    def to_s
      "#<#{self.class.name}:#{object_id} type=#{type} object=#{object}>"
    end

    def inspect
      to_s
    end
  end
end
