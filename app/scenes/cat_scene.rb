class CatScene < Pod::Scene
  attr_reader :spritesheet, :cat, :animated_sprite
  def load
    @spritesheet = $game.spritesheets.find(:cat3)
    @animated_sprite = spritesheet.animated_sprite(
      [0, 2, 0, 2, 3, 5, 3, 5, 6, 8, 6, 8],
      200, 300,
      flip_vertically: true,
      angle_anchor_x: 0.5,
      angle_anchor_y: 0,
      w: 200,
      h: 200,
    )

    @cat = Cat.new(x: 400, y: 150, mouse: mouse, keyboard: keyboard, scale_w: 2)
  end

  def tick
    @animated_sprite.angle += 1
    @animated_sprite.x += 5
    if @animated_sprite.x > grid.w
      @animated_sprite.x = 0
    end

    outputs.sprites << [
      @animated_sprite,
      @cat,
    ]
    outputs.borders << [200, 300, 32, 32]
    outputs.labels << [10, 20.from_top, "FPS: #{gtk.current_framerate.to_i}"]
  end
end
