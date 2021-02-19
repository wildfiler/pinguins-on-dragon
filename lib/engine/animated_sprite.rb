module Engine
  class AnimatedSprite < Engine::Sprite
    attr_reader :spritesheet, :sequence
    attr_accessor :start_at, :duration, :repeat

    def initialize(spritesheet:, sequence: [], start_at: 0, duration: 15, repeat: true, **attributes)
      @w = spritesheet.sprite_w
      @h = spritesheet.sprite_h
      @spritesheet = spritesheet
      @sequence = sequence
      @start_at = start_at
      @duration = duration
      @repeat = repeat

      update(attributes)
    end

    def sequence_length
      @sequence_length ||= sequence.length
    end

    def current_sprite_id
      id = start_at.frame_index(sequence_length, duration, repeat)
      sequence[id || 0]
    end

    def path
      @path ||= spritesheet.path
    end

    def sequence=(sequence)
      @sequence = sequence
      @sequence_length = nil
      @start_at = Kernel.tick_count
    end

    def draw_override(ffi_draw)
      tile_x, tile_y = spritesheet.id_to_xy(current_sprite_id)

      ffi_draw.draw_sprite_3(
        x, y, w, h,
        path,
        angle,
        r, g, b, a,
        tile_x, tile_y, spritesheet.sprite_w, spritesheet.sprite_h,
        flip_horizontally, flip_vertically,
        angle_anchor_x, angle_anchor_y,
        0, 0, -1, -1,
      )
    end

    def serialize
      {
        path: path,
        sequence: sequence,
        start_at: start_at,
        current_sprite_id: current_sprite_id,
        duration: duration,
        repeat: repeat,
        spritesheet: spritesheet,
      }
    end

    def to_s
      "#<#{self.class.name}:#{object_id} #{serialize.map {|k, v| "#{k}=#{v}"}} >"
    end
  end
end
