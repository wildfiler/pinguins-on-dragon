class Cat < Pod::CompoundSprite
  DEFAULT_SEQUENCE = [1]
  MOVE_SEQUENCES = {
    up: [9, 11],
    down: [0, 2],
    left: [3, 5],
    right: [6, 8],
    idle_up: [10],
    idle_down: [1],
    idle_left: [4],
    idle_right: [7],
  }.freeze

  def initialize(mouse: mouse, keyboard: keyboard, **attributes)
    cat = Pod::CompoundSprite.new(
      sprites: [
        $game.spritesheets.find(:cat3).animated_sprite(DEFAULT_SEQUENCE),
        $game.spritesheets.find(:shadows).animated_sprite(DEFAULT_SEQUENCE, z_index: -1)
      ]
    )

    cats = [
      cat,
      cat.dup.update(x: -32, y: 32, z_index: -1),
      cat.dup.update(x: 32, y: 32, z_index: -1),
    ]
    @moved = false

    super(sprites: cats, w: 64, h: 64, **attributes)
    subscribe(mouse, keyboard)
  end

  def subscribe(mouse, keyboard)
    mouse.subscribe(self, :click, :on_mouse_click)
    mouse.subscribe(self, :double_click, :on_mouse_double_click)
    mouse.subscribe(self, :moved, :on_mouse_move, global: true)
    mouse.subscribe(self, :up, :on_mouse_up, global: true)
    keyboard.subscribe(self, :key_held, :on_key_hold)
  end

  def on_mouse_click(event)
    @clicked = true
    @offset_x = event.object.x - x
    @offset_y = event.object.y - y
  end

  def on_mouse_double_click(event)
    @clicked = true
    self.x += 100
    self.y += 100
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
    if @clicked
      @moved = false
      set_idle_animation(@direction)
      @idle = true
      return
    end

    moved = false

    if event.keyboard.up
      self.y += 1
      set_animation(:up) if @idle
      @direction = :up
      moved = true
    end
    if event.keyboard.down
      self.y -= 1
      set_animation(:down) if @idle
      @direction = :down
      moved = true
    end
    if event.keyboard.right
      self.x += 1
      set_animation(:right) if @idle
      @direction = :right
      moved = true
    end
    if event.keyboard.left
      self.x -= 1
      set_animation(:left) if @idle
      @direction = :left
      moved = true
    end

    if moved
      @moved = true
      @idle = false
    else
      set_idle_animation(@direction) if @moved
      @idle = true
      @moved = false
    end
  end

  private

  def set_animation(type)
    sequence = move_sequence(type)
    sprites.each do |sprite|
      sprite.sprites.each do |subsprite|
        subsprite.update(sequence: sequence)
      end
    end
  end

  def set_idle_animation(type)
    return if @idle
    sequence = move_sequence(:"idle_#{type}")
    sprites.each do |sprite|
      sprite.sprites.each do |subsprite|
        subsprite.update(sequence: sequence)
      end
    end
  end

  def move_sequence(type)
    MOVE_SEQUENCES.fetch(type, DEFAULT_SEQUENCE)
  end
end
