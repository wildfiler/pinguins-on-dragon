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
  end

  def tick(args)
    outputs.labels << [20, 50.from_top, "Test"]
    outputs.sprites << [
      @sprite,
      @sprite2,
      @sprite3,
      @animated_sprite,
    ]
    outputs.borders << [200, 300, 32, 32]
    @animated_sprite.angle += 1
  end
end
