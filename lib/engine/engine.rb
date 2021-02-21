require 'lib/engine/game.rb'
require 'lib/engine/attribute_assignment.rb'
require 'lib/engine/unknown_attribute.rb'
require 'lib/engine/sprite.rb'
require 'lib/engine/animated_sprite.rb'
require 'lib/engine/compound_sprite.rb'
require 'lib/engine/spritesheet.rb'
require 'lib/engine/event.rb'
require 'lib/engine/mouse_event.rb'
require 'lib/engine/keyboard_event.rb'
require 'lib/engine/event_observer.rb'
require 'lib/engine/keyboard_events.rb'
require 'lib/engine/mouse_events.rb'
require 'lib/engine/registry.rb'
require 'lib/engine/events_dispatcher.rb'
require 'lib/engine/scene.rb'

module Engine
  module AttributeAssignment; end
  module EventObserver; end
  class Game; end
  class UnknownAttribute < NoMethodError; end
  class Sprite; end
  class AnimatedSprite < Sprite; end
  class CompoundSprite < Sprite; end
  class SpriteSheet; end
  class Event; end
  class KeyboardEvent < Event; end
  class KeyboardEvents; end
  class MouseEvent < Event; end
  class MouseEvents; end
  class Registry; end
  class EventsDispatcher; end
  class Scene; end
end
