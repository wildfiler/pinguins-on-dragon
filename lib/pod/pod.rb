require 'lib/pod/game.rb'
require 'lib/pod/attribute_assignment.rb'
require 'lib/pod/unknown_attribute.rb'
require 'lib/pod/sprite.rb'
require 'lib/pod/animated_sprite.rb'
require 'lib/pod/compound_sprite.rb'
require 'lib/pod/spritesheet.rb'
require 'lib/pod/event.rb'
require 'lib/pod/mouse_event.rb'
require 'lib/pod/keyboard_event.rb'
require 'lib/pod/event_observer.rb'
require 'lib/pod/keyboard_events.rb'
require 'lib/pod/mouse_events.rb'
require 'lib/pod/registry.rb'
require 'lib/pod/events_dispatcher.rb'
require 'lib/pod/scene.rb'
require 'lib/pod/nine_sliced_sprite.rb'
require 'lib/pod/ui.rb'
require 'lib/pod/ui/label.rb'
require 'lib/pod/ui/button.rb'

module Pod
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
  class NineSlicedSprite; end
  module UI
    class Label; end
    class Button; end
  end
end
