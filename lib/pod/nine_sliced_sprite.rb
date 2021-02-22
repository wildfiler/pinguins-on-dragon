module Pod
  class NineSlicedSprite
    include Pod::AttributeAssignment

    attr_reader :x, :y, :w, :h, :spritesheet, :sprite_w, :sprite_h
    attr_rect

    attr_accessor :visible, :z_index

    def initialize(x: 0, y: 0, w:, h:, z_index: 0, corners_ids: (0..8), spritesheet:, visible: true)
      @spritesheet = spritesheet
      @sprite_w = spritesheet.sprite_w
      @sprite_h = spritesheet.sprite_h
      @corners_ids = corners_ids
      update(
        x: x,
        y: y,
        w: w,
        h: h,
        z_index: z_index,
      )
      @visible = visible
    end

    def visible?
      @visible
    end

    def draw_override(ffi_draw)
      draw(ffi_draw)
    end

    def draw(ffi_draw, origin_x = 0, origin_y = 0, _scale_w = 1.0, _scale_h = 1.0)
      return unless visible?

      sprites.each do |((tile_x, tile_y), (s_x, s_y, s_w, s_h))|
        next if s_w <= 0 || s_h <= 0

        ffi_draw.draw_sprite_3(
          origin_x + s_x, origin_y + s_y, s_w, s_h,
          path,
          0,
          255, 255, 255, 255,
          tile_x, tile_y, sprite_w, sprite_h,
          false, false,
          0, 0,
          0, 0, -1, -1,
        )
      end
    end

    def path
      @path ||= spritesheet.path
    end

    def min_w
      @min_w ||= 2 * sprite_w
    end

    def min_h
      @min_h ||= 2 * sprite_h
    end

    def x=(value)
      @x = value
      clear_cache!
    end

    def y=(value)
      @y = value
      clear_cache!
    end

    def w=(value)
      @w = value.greater(min_w)
      clear_cache!
    end

    def h=(value)
      @h = value.greater(min_h)
      clear_cache!
    end

    private

    def sprites
      @sprites ||= tiles_xys.zip(corners_xys)
    end

    def tiles_xys
      @tiles_xys ||= @corners_ids.map do |i|
        spritesheet.id_to_xy(i)
      end
    end

    def corners_xys
      @corners_xys ||= [
        [left, top - sprite_h, sprite_w, sprite_h],
        [left + sprite_w, top - sprite_h, w - 2 * sprite_w, sprite_h],
        [right - sprite_w, top - sprite_h, sprite_w, sprite_h],
        [left, bottom + sprite_h, sprite_w, h - 2 * sprite_h],
        [left + sprite_w, bottom + sprite_h, w - 2 * sprite_w, h - 2 * sprite_h],
        [right - sprite_w, bottom + sprite_h, sprite_w, h - 2 * sprite_h],
        [left, bottom, sprite_w, sprite_h],
        [left + sprite_w, bottom, w - 2 * sprite_w, sprite_h],
        [right - sprite_w, bottom, sprite_w, sprite_h],
      ]
    end

    def clear_cache!
      @corners_xys = nil
      @sprites = nil
    end
  end
end
