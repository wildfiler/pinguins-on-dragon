module Pod
  class AnimatedSprite < Pod::Sprite
    attr_reader :spritesheet, :sequence
    attr_accessor :start_at, :duration, :repeat

    def initialize(spritesheet:, sequence: [], start_at: 0, duration: 15, repeat: true, **attributes)
      update(
        w: spritesheet.sprite_w,
        h: spritesheet.sprite_h,
        tile_w: spritesheet.sprite_w,
        tile_h: spritesheet.sprite_h,
        sequence: sequence,
        start_at: start_at,
        duration: duration,
        repeat: repeat,
      )
      @spritesheet = spritesheet

      super(**attributes)
    end

    def sequence_length
      @sequence_length ||= sequence&.length
    end

    def current_sprite_id
      id = start_at.frame_index(sequence_length, duration, repeat)
      sequence[id || 0]
    end

    def path
      @path ||= spritesheet&.path
    end

    def sequence=(sequence)
      @sequence = sequence
      @sequence_length = nil
      @start_at = Kernel.tick_count
    end

    def draw_override(ffi_draw)
      draw(ffi_draw, 0, 0)
    end

    def tile_xy
      spritesheet.id_to_xy(current_sprite_id)
    end

    def tile_x
      tile_xy.x
    end

    def tile_y
      tile_xy.y
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

    def inspect
      "#<#{self.class.name}:#{object_id} #{serialize.map { |k, v| "#{k}=#{v}" }.join" "} >"
    end

    def to_s
      inspect
    end
  end
end
