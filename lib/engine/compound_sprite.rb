module Engine
  class CompoundSprite < Engine::Sprite
    attr_accessor :sprites, :scale_w, :scale_h

    def initialize(sprites:, scale_w: 1.0, scale_h: nil, **attributes)
      scale_h ||= scale_w
      super(x: 0, y: 0, **attributes)
      self.sprites = sprites.sort_by.with_index{ |sprite, index| [sprite.z_index, index] }
      update(
        scale_w: scale_w,
        scale_h: scale_h,
      )
    end

    def draw_override(ffi_draw)
      return unless visible?

      draw(ffi_draw, 0, 0, scale_w, scale_h)
    end

    def draw(ffi_draw, origin_x, origin_y, scale_w = 1.0, scale_h = 1.0)
      return unless visible?

      if path
        super(ffi_draw, origin_x, origin_y, scale_w, scale_h)
      end

      sprites.each do |sprite|
        sprite.draw(ffi_draw, origin_x + x, origin_y + y, scale_w, scale_h)
      end
    end

    def serialize
      self_info = if path
        {
          path: path,
          w: w,
          h: h,
          z_index: z,
        }
      else
        {}
      end

      tile_info = if tile_x || tile_y || tile_w || tile_h
        {
          tile_x: tile_x,
          tile_y: tile_y,
          tile_w: tile_w,
          tile_h: tile_h,
        }
      else
        {}
      end

      {
        x: x,
        y: y,
        **self_info,
        angle: angle,
        angle_anchor_x: angle_anchor_x,
        angle_anchor_y: angle_anchor_y,
        flip_horizontally: flip_horizontally,
        flip_vertically: flip_vertically,
        sprites: sprites,
        **tile_info,
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
