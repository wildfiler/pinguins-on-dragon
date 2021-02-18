module Engine
  class KeyboardEvents
    include Engine::EventObserver

    def tick(args)
      keyboard = args.inputs.keyboard

      unless keyboard.key_down.truthy_keys.empty?
        trigger(Engine::KeyboardEvent.new(:key_down, keyboard.key_down, keyboard))
      end

      unless keyboard.key_down.truthy_keys.empty?
        trigger(Engine::KeyboardEvent.new(:key_up, keyboard.key_up, keyboard))
      end

      unless keyboard.key_held.truthy_keys.empty?
        trigger(Engine::KeyboardEvent.new(:key_held, keyboard.key_held, keyboard))
      end
    end
  end
end
