module Pod
  class SpriteSheet
    attr_reader :name, :sprite_w, :sprite_h, :width, :spacing

    def initialize(path: nil, name: nil, sprite_size:, width:, spacing: 0)
      @path = path
      @name = name
      @sprite_w = sprite_size[0]
      @sprite_h = sprite_size[1]
      @width = width
      @spacing = spacing
      @row_size = width / (sprite_w + spacing)
    end

    def path
      if name
        @path ||= "sprites/#{name}.png"
      else
        super
      end
    end

    def sprite(id, x = 0, y = 0, klass: Pod::Sprite, **attributes)
      tile_x, tile_y = id_to_xy(id)

      klass.new(
        x: x,
        y: y,
        w: sprite_w,
        h: sprite_h,
        tile_x: tile_x,
        tile_y: tile_y,
        tile_w: sprite_w,
        tile_h: sprite_h,
        path: path,
        **attributes
      )
    end

    def animated_sprite(sequence, x = 0, y = 0, klass: Pod::AnimatedSprite, **attributes)
      klass.new(
        x: x,
        y: y,
        w: sprite_w,
        h: sprite_h,
        tile_w: sprite_w,
        tile_h: sprite_h,
        sequence: sequence,
        spritesheet: self,
        **attributes
      )
    end

    def id_to_xy(id)
      y, x = id.divmod(@row_size)
      [x.to_i * (sprite_w + spacing), y.to_i * (sprite_h + spacing)]
    end
  end
end
