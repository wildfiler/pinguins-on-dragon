require 'lib/engine/animated_sprite_docs.rb'
require 'lib/engine/game_docs.rb'

module Engine
  module EngineDocs
    def docs_module
      <<-DOCS
* ENGINE: ~Engine~

Module of engine that contains all related classes.
      DOCS
    end
  end

  extend Docs
  extend EngineDocs
end
