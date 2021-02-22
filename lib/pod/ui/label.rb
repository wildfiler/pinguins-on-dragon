module Pod
  module UI
    class Label
      include Pod::AttributeAssignment

      attr_rect
      attr_accessor :x, :y, :w, :h, :r, :g, :b, :a, :z_index, :visible, :size_enum, :alignment_enum
      attr_reader :text

      def initialize(**attributes)
        update(
          x: 0,
          y: 0,
          z_index: 0,
          size_enum: 0,
          alignment_enum: 0,
          r: 0,
          g: 0,
          b: 0,
          a: 255,
          text: "Label",
          visible: true,
          **attributes
        )
      end

      def visible?
        visible
      end

      def w
        @w ||= text_wh[0]
      end

      def h
        @h ||= text_wh[1]
      end

      def draw_override(ffi_draw)
        draw(ffi_draw, 0, 0)
      end

      def draw(ffi_draw, origin_x, origin_y, scale_w = 1.0, scale_h = 1.0)
        return unless visible?

        ffi_draw.draw_label(origin_x + x, origin_y + y + h, text, size_enum, alignment_enum, r, g, b, a, nil)
      end

      private

      attr_writer :text

      def text_wh
        @text_wh ||= $gtk.calcstringbox(text)
      end
    end
  end
end
