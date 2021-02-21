module Pod
  module AnimatedSpriteDocs

    def docs_method_sort_order
      [
        :docs_class,
        :docs_new,
        :docs_sequence=,
      ]
    end

    def docs_class
      <<-DOCS
* LIB: ~Pod::AnimatedSprite~

  This is class for creating animated sprites from spritesheets. Subclass of ~Pod::Sprite~.
      DOCS
    end

    def docs_new
      <<-DOCS
* LIB: ~Pod::AnimatedSprite.new~      
  To show sequence of sprites from ~Spritesheet~ you need to pass array of ids in sequence attribute:

#+begin_src ruby
  spritesheet = Pod::SpriteSheet.new(name: "cat", width: 32 * 3, sprite_size: [32, 32])
  sprite = Pod::AnimatedSprite.new(
    x: 100, 
    y: 100,
    spritesheet: spritesheet, 
    sequence: [3, 4, 5, 6, 5, 4, 3],
  )

  args.outputs << sprite
#+end_src

*** Attributes:

- spritesheet - ~Pod::Spritesheet~ object
- sequence - ~Array~ of sprites id from ~Pod::Spritesheet~
- start_at - start animation at ~start_at~ tick
- duration - duration in ticks, default is 15
- repeat - ~true~ or ~false~

  All ~Pod::Sprite~ attributes can be used too.
      DOCS
    end

    def docs_sequence=
      <<-DOCS
* LIB: ~Pod::AnimatedSprite#sequence=~

  You can change sequence for sprite dynamically:

#+begin_src
def tick(args)
  if args.state.tick_count.zero?
    args.state.spritesheet = Pod::SpriteSheet.new(name: "penguin", width: 32 * 3, sprite_size: [32, 32]) 
    args.state.penguin = Pod::AnimatedSprite.new(
      spritesheet: spritesheet, 
      sequence: [0, 1, 2],
    )
  end

  if args.inputs.ketboard.key_held.space
    args.state.penguin.sequence = [3, 4, 5]
  end
end
#+end_src

  It will set new sequence for the animation and will set ~start_at~ of the sprite to current tick_count.
      DOCS
    end
  end

  class AnimatedSprite < Pod::Sprite
    extend Docs
    extend AnimatedSpriteDocs
  end
end
