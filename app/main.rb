require 'lib/pod/pod.rb'
require 'lib/pod/pod_docs.rb'
require 'app/my_game.rb'
require 'app/cat.rb'
require 'app/scenes/cat_scene.rb'
require 'app/scenes/start_scene.rb'

def tick(args)
  Pod::Game.tick(MyGame, args)
end
