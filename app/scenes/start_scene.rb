class StartScene < Pod::Scene
  def load
    @cats = three_cats
    @label = [grid.w_half + 16, 300.from_top, "Press any key to start.", 10, 1]
    mouse.subscribe(self, :up, :change_scene)
    keyboard.subscribe(self, :all, :change_scene)
  end

  def tick
    outputs.sprites << @cats
    outputs.labels << @label
  end

  def change_scene(_event)
    @next_scene = CatScene.new
  end

  private

  def three_cats
    cat = Pod::CompoundSprite.new(
      sprites: [
        $game.spritesheets.find(:cat3).animated_sprite([0, 2], w: 128, h: 128),
        $game.spritesheets.find(:shadows).animated_sprite([0, 2], w: 128, h: 128, z_index: -1)
      ],
    )

    cats = [
      cat,
      cat.dup.update(x: -128),
      cat.dup.update(x: +128),
    ]

    Pod::CompoundSprite.new(sprites: cats, x: grid.w_half - 65, y: 300.from_top)
  end
end
