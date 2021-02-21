class MyGame < Pod::Game
  def init
    spritesheets.add(:cat3, Pod::SpriteSheet.new(name: "Cat 01-3", width: 32 * 3, sprite_size: [32, 32]))
    spritesheets.add(:shadows, Pod::SpriteSheet.new(name: "Shadow 3 Animal", width: 32 * 3, sprite_size: [32, 32]))
    self.scene = StartScene.new
  end
end
