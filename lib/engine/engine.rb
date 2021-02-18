require 'lib/engine/game.rb'
require 'lib/engine/attribute_assignment.rb'
require 'lib/engine/unknown_attribute.rb'
require 'lib/engine/sprite.rb'
require 'lib/engine/animated_sprite.rb'
require 'lib/engine/spritesheet.rb'

module Engine
  module AttributeAssignment; end
  class Game; end
  class UnknownAttribute < NoMethodError; end
  class Sprite; end
  class AnimatedSprite < Sprite; end
  class SpriteSheet; end
end
