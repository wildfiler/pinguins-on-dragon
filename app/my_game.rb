
class Cat < Engine::AnimatedSprite
  DEFAULT_SEQUENCE = [1]
  MOVE_SEQUENCES = {
    up: [9, 11],
    down: [0, 2],
    left: [3, 5],
    right: [6,8],
    idle_up: [10],
    idle_down: [1],
    idle_left: [4],
    idle_right: [7],
  }.freeze

  def initialize(*)
    super
    @moved = false
  end

  def on_mouse_click(event)
    @clicked = true
    @offset_x = event.object.x - x
    @offset_y = event.object.y - y
  end

  def on_mouse_move(event)
    if @clicked
      self.x = event.mouse.x - @offset_x
      self.y = event.mouse.y - @offset_y
    end
  end

  def on_mouse_up(event)
    @clicked = false
  end

  def on_key_hold(event)
    moved = false

    if event.keyboard.up
      self.y += 1
      set_animation(:up)
      moved = true
    end
    if event.keyboard.down
      self.y -= 1
      set_animation(:down)
      moved = true
    end
    if event.keyboard.right
      self.x += 1
      set_animation(:right)
      moved = true
    end
    if event.keyboard.left
      self.x -= 1
      set_animation(:left)
      moved = true
    end

    if moved
      @moved = true
    else
      set_animation(:"idle_#{@direction}") if @moved
      @moved = false
    end
  end

  private

  def set_animation(type)
    self.sequence = move_sequence(type) if @direction != type
    @direction = type
  end

  def move_sequence(type)
    MOVE_SEQUENCES.fetch(type, DEFAULT_SEQUENCE)
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

    @cat = Cat.new(x: 400, y: 150, spritesheet: @spritesheet, sequence: [0, 2])
    mouse.subscribe(@cat, :click, :on_mouse_click)
    mouse.subscribe(@cat, :moved, :on_mouse_move, global: true)
    mouse.subscribe(@cat, :up, :on_mouse_up, global: true)
    keyboard.subscribe(@cat, :key_held, :on_key_hold)
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
