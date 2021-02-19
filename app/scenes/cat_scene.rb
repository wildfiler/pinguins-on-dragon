class CatScene < Engine::Scene
  def load
    @spritesheet = $game.spritesheets.find(:cat3)
    @animated_sprite = Engine::AnimatedSprite.new(x: 200, y: 300, spritesheet: @spritesheet, sequence: [0, 2, 0, 2, 3, 5, 3, 5, 6, 8, 6, 8])
    @animated_sprite.update(
      flip_vertically: true,
      angle_anchor_x: 0.5,
      angle_anchor_y: 0,
      w: 100,
      h: 100,
    )

    @cat = Cat.new(x: 400, y: 150, spritesheet: @spritesheet)
    mouse.subscribe(@cat, :click, :on_mouse_click)
    mouse.subscribe(@cat, :double_click, :on_mouse_double_click)
    mouse.subscribe(@cat, :moved, :on_mouse_move, global: true)
    mouse.subscribe(@cat, :up, :on_mouse_up, global: true)
    keyboard.subscribe(@cat, :key_held, :on_key_hold)
  end

  def tick
    @animated_sprite.angle += 1
    @animated_sprite.x += 5
    if @animated_sprite.x > grid.w
      @animated_sprite.x = 0
    end

    outputs.labels << [20, 50.from_top, "Test"]
    outputs.sprites << [
      @animated_sprite,
      @board,
      @cat,
    ]
    outputs.borders << [200, 300, 32, 32]
  end
end
