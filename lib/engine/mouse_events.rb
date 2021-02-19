module Engine
  class MouseEvents
    include Engine::EventObserver

    def tick(args)
      mouse = args.inputs.mouse

      if mouse.click
        trigger_new_event(:click, mouse.click, mouse)
        if @last_click
          if (@last_click + 0.5.seconds).elapsed?
            @last_click = Kernel.tick_count
          else
            trigger_new_event(:double_click, mouse.click, mouse)
            @last_click = nil
          end
        else
          @last_click = Kernel.tick_count
        end
      end

      if mouse.moved
        trigger_new_event(:moved, mouse)
      end

      if mouse.up
        trigger_new_event(:up, mouse.up, mouse)
      end
    end

    def subscribe(subscriber, type = nil, callback = nil, global: false)
      is_rect = [:x, :y, :right, :top].any? { |method| subscriber.respond_to?(method) }
      subscribers << [subscriber, type, callback, global || !is_rect]
    end

    def __valid_event?(event, *subscriber_args)
      subscriber, type, _callback, global = subscriber_args

      (type == event.type || type == :all) && (global || event.mouse.inside_rect?(subscriber))
    end

    def event_class
      @event_class ||= Engine::MouseEvent
    end
  end
end
