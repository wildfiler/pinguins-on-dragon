module Engine
  class MouseEvents
    include Engine::EventObserver

    def tick(args)
      mouse = args.inputs.mouse

      if mouse.click
        trigger(Engine::MouseEvent.new(:click, mouse.click, mouse))
      end

      if mouse.moved
        trigger(Engine::MouseEvent.new(:moved, mouse, mouse))
      end

      if mouse.up
        trigger(Engine::MouseEvent.new(:up, mouse.up, mouse))
      end
    end

    def subscribe(subscriber, type = nil, callback = nil, global: false)
      is_rect = [:x, :y, :right, :top].any? { |method| subscriber.respond_to?(method) }
      subscribers << [subscriber, type, callback, global || !is_rect]
    end

    def trigger(event)
      subscribers.each do |(subscriber, type, callback, global)|
        next unless type == event.type
        next unless global || event.mouse.inside_rect?(subscriber)

        if callback
          subscriber.send(callback, event)
        else
          subscriber.call(event)
        end
      end
    end
  end
end
