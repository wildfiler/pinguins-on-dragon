module Engine
  module EventObserver
    def subscribers
      @subscribers ||= []
    end

    def subscribe(subscriber, type = nil, callback = nil)
      subscribers << [subscriber, type, callback]
    end

    def unsubscribe(unsubscriber)
      subscribers.delete_if { |(subscriber, *)| subscriber == unsubscriber }
    end

    def trigger(event)
      subscribers.each do |(subscriber, type, callback)|
        next unless type == event.type

        if callback
          subscriber.send(callback, event)
        else
          subscriber.call(event)
        end
      end
    end
  end
end
