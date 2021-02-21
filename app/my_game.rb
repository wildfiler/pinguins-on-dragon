class MyGame < Engine::Game
  def init
    spritesheets.add(:cat3, Engine::SpriteSheet.new(name: "Cat 01-3", width: 32 * 3, sprite_size: [32, 32]))
    spritesheets.add(:shadows, Engine::SpriteSheet.new(name: "Shadow 3 Animal", width: 32 * 3, sprite_size: [32, 32]))
    self.scene = StartScene.new
  end
end
