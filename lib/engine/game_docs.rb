module Engine
  module GameDocs
    def docs_method_sort_order
      [
        :docs_class,
        :docs_tick,
      ]
    end

    def docs_class
      <<-DOCS
* ENGINE: ~Engine::Game~

This is main game class of engine. Your custom game class should be a subclass of this class.
  
~app/my_game.rb:~
#+begin_src ruby
  class MyGame < Engine::Game
  end
#+end_src

~app/main.rb~
#+begin_src ruby
  require 'lib/engine/engine.rb'
  require 'app/my_game.rb'

  def tick(args)
    Engine::Game.tick(MyGame, args)
  end
#+end_src
      DOCS
    end

    def docs_tick
      <<-DOCS
* ENGINE: ~Engine::Game.tick~
  
  Use this method in ~app/main.rb~ tick method to perform initialization of your game class and call its ~tick~ method
on every frame.

  #+begin_src ruby
    require 'lib/engine/engine.rb'
    require 'app/my_game.rb'
    
    def tick(args)
      Engine::Game.tick(MyGame, args)
    end
  #+end_src
      DOCS
    end
  end

  class Game
    extend Docs
    extend GameDocs
  end
end
