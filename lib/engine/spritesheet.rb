module Engine
  class SpriteSheet
    attr_reader :name, :sprite_w, :sprite_h, :width

    def initialize(path: nil, name: nil, sprite_size:, width:)
      @path = path
      @name = name
      @sprite_w = sprite_size[0]
      @sprite_h = sprite_size[1]
      @width = width
      @row_size = width / sprite_w
    end

    def path
      if name
        @path ||= "sprites/#{name}.png"
      else
        super
      end
    end

    def sprite(id, x = 0, y = 0, klass: Engine::Sprite)
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
      )
    end

    def animated_sprite(sequence, x = 0, y = 0, klass: Engine::AnimatedSprite)
      klass.new(
        x: x,
        y: y,
        sequence: sequence,
        spritesheet: self,
      )
    end

    def id_to_xy(id)
      y, x = id.divmod(@row_size)
      [x * sprite_w, y * sprite_h]
    end
  end
end
