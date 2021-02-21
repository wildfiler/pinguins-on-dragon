module Pod
  class EventsDispatcher
    attr_reader :events, :observer

    def initialize(events)
      @events = events
      @observer = events.class.new
    end

    def dispatch(event)
      observer.trigger(event)
    end

    def stop
      events.unsubscribe(self)
    end

    def start
      events.subscribe(self, :all, :dispatch)
    end

    def subscribe(*args, **kargs)
      observer.subscribe(*args, **kargs)
    end

    def unsubscribe(*args)
      observer.unsubscribe(*args)
    end
  end
end
