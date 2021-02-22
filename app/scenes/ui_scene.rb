class UIScene < Pod::Scene
  attr_reader :button

  def load
    @button = Pod::UI::Button.new(x: 200, y: 200.from_top, w: 200, h: 50, mouse: mouse, text: "Some button")
    @count = 0
    @button.subscribe(
      -> (_event) {
        @count += 1
      },
      :clicked,
    )
  end

  def tick
    outputs.sprites << [
      @sprite,
      @button,
    ]

    outputs.labels << [200, 250.from_top, "clicked: #{@count}", 0, 0, 0, 255]
  end
end
