class Scene
  attr_gtk

  attr_reader :keyboard, :mouse, :next_scene

  def initialize(**attributes)
    @keyboard = Engine::EventsDispatcher.new(attributes[:keyboard] || $game.keyboard)
    @mouse = Engine::EventsDispatcher.new(attributes[:mouse] || $game.mouse)
  end

  def before_load
    keyboard.start
    mouse.start
  end

  def after_load
  end

  def load
  end

  def before_unload
    keyboard.stop
    mouse.stop
  end

  def after_unload
  end

  def unload
  end

  def tick
  end
end

class MyGame < Engine::Game
  def init
    spritesheets.add(:cat3, Engine::SpriteSheet.new(name: "Cat 01-3", width: 32 * 3, sprite_size: [32, 32]))
    self.scene = StartScene.new
  end
end
