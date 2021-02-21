require 'lib/pod/animated_sprite_docs.rb'
require 'lib/pod/game_docs.rb'

module Pod
  module PodDocs
    def docs_module
      <<-DOCS
* LIB: ~Pod~

Module of engine that contains all related classes.
      DOCS
    end
  end

  extend Docs
  extend PodDocs
end
