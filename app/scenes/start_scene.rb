class StartScene < Pod::Scene
  def load
    @cats = three_cats
    @button = Pod::UI::Button.new(x: grid.w_half - 50, y: 400.from_top, w: 100, h: 50, mouse: mouse, text: "Start!")
    @button.subscribe(self, :clicked, :change_scene)
  end

  def tick
    outputs.sprites << @cats
    if @next_scene_at && (@next_scene_at - 1.8.seconds).elapsed?
      @button.visible = false
      outputs.labels << [grid.w_half + 16, 350.from_top, "Loading...", 10, 1]
    else
      outputs.sprites << @button
    end
  end

  def change_scene(_event)
    @next_scene_at = tick_count + 2.seconds
  end

  def next_scene
    if @next_scene_at&.elapsed?
      CatScene.new
    end
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
