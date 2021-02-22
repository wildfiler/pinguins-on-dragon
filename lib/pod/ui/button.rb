module Pod
  module UI
    class Button
      include Pod::AttributeAssignment
      include Pod::EventObserver

      attr_rect
      attr_reader :w, :h, :ui_spritesheets, :mouse, :sprite, :text
      attr_accessor :visible, :x, :y

      def initialize(**attributes)
        update(
          ui_spritesheets: $game.ui_spritesheets,
          x: 0,
          y: 0,
          w: 0,
          h: 0,
          visible: true,
          **attributes
        )

        init_sprites
        init_mouse
      end

      def visible?
        visible
      end

      def pressed?
        @pressed
      end

      def w=(w)
        @w = w.greater(0)
        update_size!
        @w
      end

      def h=(h)
        @h = h.greater(0)
        update_size!
        @h
      end

      def draw_override(ffi_draw)
        draw(ffi_draw, 0, 0)
      end

      def draw(ffi_draw, origin_x, origin_y, scale_w = 1.0, scale_h = 1.0)
        return unless visible?

        sprite.draw(ffi_draw, origin_x + x, origin_y + y, scale_w, scale_h)
      end

      def on_mouse_click(event)
        return unless visible?
        pressed!
        trigger(event)
      end

      def on_mouse_move(event)
        return unless pressed? && visible?

        unless event.object.intersect_rect? self
          unpressed!
        end
      end

      def on_mouse_up(event)
        if pressed? && visible?
          unpressed!
          trigger(event)
          trigger(Pod::Event.new(:clicked, self, origin_event: event))
        end
      end

      private

      attr_writer :ui_spritesheets, :mouse, :text

      def pressed!
        @pressed = true
        @normal_sprite.visible = false
        @pressed_sprite.visible = true
        @label_sprite.y -= 2
      end

      def unpressed!
        @pressed = false
        @normal_sprite.visible = true
        @pressed_sprite.visible = false
        @label_sprite.y += 2
      end

      def init_sprites
        @label_sprite = Pod::UI::Label.new(text: text, alignment_enum: 1)
        button_normal = ui_spritesheets.find(:button_normal)
        @normal_sprite = Pod::NineSlicedSprite.new(spritesheet: button_normal, w: w, h: h)
        @pressed_sprite = Pod::NineSlicedSprite.new(spritesheet: ui_spritesheets.find(:button_pressed), w: w, h: h, visible: false)
        update_size!
        @sprite = Pod::CompoundSprite.new(sprites: [@normal_sprite, @pressed_sprite, @label_sprite])
      end

      def update_size!
        @label_sprite.update(x: w.half, y: h.half - @label_sprite.h.half) if @label_sprite
        @normal_sprite&.update(w: w, h: h)
        @pressed_sprite&.update(w: w, h: h)
      end

      def init_mouse
        mouse.subscribe(self, :click, :on_mouse_click)
        mouse.subscribe(self, :up, :on_mouse_up, global: true)
        mouse.subscribe(self, :moved, :on_mouse_move, global: true)
      end
    end
  end
end
