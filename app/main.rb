require 'lib/engine/engine.rb'
require 'lib/engine/engine_docs.rb'
require 'app/my_game.rb'
require 'app/cat.rb'
require 'app/scenes/cat_scene.rb'
require 'app/scenes/start_scene.rb'

def tick(args)
  Engine::Game.tick(MyGame, args)
end
