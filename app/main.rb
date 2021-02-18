require 'lib/engine/engine.rb'
require 'lib/engine/engine_docs.rb'
require 'app/my_game.rb'

def tick(args)
  Engine::Game.tick(MyGame, args)
end
