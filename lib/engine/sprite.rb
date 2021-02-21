module Engine
  class Sprite
    attr_sprite

    include Engine::AttributeAssignment

    attr_reader :name
    attr_accessor :z_index, :visible

    def initialize(name: nil, **attributes)
      @name = name

      update(
        z_index: 0,
        angle: 0,
        visible: true,
        **attributes
      )
    end

    def path
      if name
        @path ||= "sprites/#{name}.png"
      else
        super
      end
    end

    def rect
      [x, y, w, h]
    end

    def visible?
      @visible
    end

    def draw_override(ffi_draw)
      return unless visible?

      draw(ffi_draw, 0, 0)
    end

    def draw(ffi_draw, origin_x, origin_y, scale_w = 1.0, scale_h = 1.0)
      return unless visible?

      scaled_w = if scale_w != 1.0
        (w * scale_w)
      else
        w
      end

      scaled_h = if scale_h != 1.0
        (h * scale_h)
      else
        h
      end

      ffi_draw.draw_sprite_3(
        origin_x + x, origin_y + y, scaled_w, scaled_h,
        path,
        angle,
        r, g, b, a,
        tile_x, tile_y, tile_w, tile_h,
        flip_horizontally, flip_vertically,
        angle_anchor_x, angle_anchor_y,
        0, 0, -1, -1,
      )
    end

    def serialize
      {
        path: path,
        x: x,
        y: y,
        w: w,
        h: h,
        z_index: z,
        tile_x: tile_x,
        tile_y: tile_y,
        tile_w: tile_w,
        tile_h: tile_h,
        angle: angle,
        angle_anchor_x: angle_anchor_x,
        angle_anchor_y: angle_anchor_y,
        flip_horizontally: flip_horizontally,
        flip_vertically: flip_vertically,
      }
    end

    def inspect
      "#<#{self.class.name}:#{object_id} #{serialize.map { |k, v| "#{k}=#{v.inspect}" }.join" "} >"
    end

    def to_s
      inspect
    end
  end
end
