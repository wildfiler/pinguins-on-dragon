
class Cat < Engine::AnimatedSprite
  def on_mouse_click(event)
    @clicked = true
    @offset_x = event.object.x - x
    @offset_y = event.object.y - y
  end

  def on_mouse_move(event)
    if @clicked
      puts event.mouse
      self.x = event.mouse.x - @offset_x
      self.y = event.mouse.y - @offset_y
    end
  end

  def on_mouse_up(event)
    @clicked = false
  end
end

class MyGame < Engine::Game
  def init(args)
    @spritesheet = Engine::SpriteSheet.new(name: "Cat 01-3", width: 32 * 3, sprite_size: [32, 32])
    @sprite = Engine::Sprite.new(x: 10, y: 10, w: 100, h: 100, name: "Cat 01-2")
    @sprite2 = @spritesheet.sprite(6)
    @sprite3 = @spritesheet.sprite(5, 200, 200)
    @animated_sprite = Engine::AnimatedSprite.new(x: 200, y: 300, spritesheet: @spritesheet, sequence: [0, 2, 0, 2, 3, 5, 3, 5, 6, 8, 6, 8])
    @animated_sprite.update(
      flip_vertically: true,
      angle_anchor_x: 0.5,
      angle_anchor_y: 0,
      w: 100,
      h: 100,
    )
    @sprite2.attributes = { x: 100, y: 100 }
    @keyboard = Engine::KeyboardEvents.new
    @keyboard.subscribe(self, :key_held, :on_key_hold)

    @mouse = Engine::MouseEvents.new

    @cat = Cat.new(x: 400, y: 150, spritesheet: @spritesheet, sequence: [0, 2])
    @mouse.subscribe(@cat, :click, :on_mouse_click)
    @mouse.subscribe(@cat, :moved, :on_mouse_move, global: true)
    @mouse.subscribe(@cat, :up, :on_mouse_up, global: true)
    @mouse.subscribe(-> (event) { puts event.object }, :up)
  end

  def mouse_events
    @mouse
  end

  def on_click(event)
    puts event.object
  end

  def on_moved(event)
    puts event.object
  end

  def on_key_hold(event)
    if event.keyboard.up
      @animated_sprite.y += 1
    end

    if event.keyboard.down
      @animated_sprite.y -= 1
    end
  end

  def tick(args)
    @keyboard.tick(args)
    @mouse.tick(args)
    @animated_sprite.angle += 1
    @animated_sprite.x += 5
    if @animated_sprite.x > grid.w
      @animated_sprite.x = 0
    end

    outputs.labels << [20, 50.from_top, "Test"]
    outputs.sprites << [
      @sprite,
      @sprite2,
      @sprite3,
      @animated_sprite,
      @cat,
    ]
    outputs.borders << [200, 300, 32, 32]
  end
end
