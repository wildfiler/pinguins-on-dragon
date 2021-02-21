module Pod
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
      "#<#{self.class.name}:#{object_id} type=#{type} object=#{object}>"
    end

    def inspect
      to_s
    end
  end
end
