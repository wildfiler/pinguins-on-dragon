class MyGame < Pod::Game
  def init
    spritesheets.add(:cat3, Pod::SpriteSheet.new(name: "Cat 01-3", width: 32 * 3, sprite_size: [32, 32]))
    spritesheets.add(:shadows, Pod::SpriteSheet.new(name: "Shadow 3 Animal", width: 32 * 3, sprite_size: [32, 32]))
    ui_spritesheets.add(:button_normal, Pod::SpriteSheet.new(name: "ui/buttons/blue", sprite_size: [16, 16], width: 48))
    ui_spritesheets.add(:button_pressed, Pod::SpriteSheet.new(name: "ui/buttons/blue_pressed", sprite_size: [16, 16], width: 48))
    self.scene = StartScene.new
  end
end
