class StartScene < Engine::Scene
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
    spritesheet = $game.spritesheets.find(:cat3)

    cats = [
      spritesheet.animated_sprite([3, 5], grid.w_half - 192, 300.from_top),
      spritesheet.animated_sprite([0, 2], grid.w_half - 64, 300.from_top),
      spritesheet.animated_sprite([6, 8], grid.w_half + 64, 300.from_top),
    ]

    cats.each do |cat|
      cat.update(w: 128, h: 128)
    end

    cats
  end
end
