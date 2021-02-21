module Pod
  module EventObserver
    def subscribers
      @subscribers ||= []
    end

    def subscribe(subscriber, type = nil, callback = nil, global: false)
      subscribers << [subscriber, type, callback, global]
    end

    def unsubscribe(unsubscriber)
      subscribers.delete_if { |(subscriber, *)| subscriber == unsubscriber }
    end

    def trigger(event)
      subscribers.each do |subscriber_args|
        next unless __valid_event?(event, *subscriber_args)
        subscriber, _type, callback = subscriber_args

        if callback
          subscriber.send(callback, event)
        else
          subscriber.call(event)
        end
      end
    end

    def __valid_event?(event, *subscriber_args)
      _subscriber, type, _callback = subscriber_args

      type == event.type || type == :all
    end

    def trigger_new_event(type, object = nil, mouse)
      trigger(event_class.new(type, object || mouse, mouse))
    end

    def event_class
      raise "You need to define event_class method in your observer class."
    end
  end
end
