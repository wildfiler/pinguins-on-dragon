module Pod
  class KeyboardEvents
    include Pod::EventObserver

    def tick(args)
      keyboard = args.inputs.keyboard

      unless keyboard.key_down.truthy_keys.empty?
        trigger_new_event(:key_down, keyboard.key_down, keyboard)
      end

      unless keyboard.key_down.truthy_keys.empty?
        trigger_new_event(:key_up, keyboard.key_up, keyboard)
      end

      unless keyboard.key_held.truthy_keys.empty?
        trigger_new_event(:key_held, keyboard.key_held, keyboard)
      end
    end

    def event_class
      @event_class ||= Pod::KeyboardEvent
    end
  end
end
