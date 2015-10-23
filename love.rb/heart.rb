filename = 'heart.marshal'

if ARGV == ['png']
  require 'chunky_png'
  image = ChunkyPNG::Image.from_file("heart.png")
  bits  = image.height.times.map do |y|
    image.width.times.map do |x|
      image[x, y] != 0
    end
  end
  File.write filename, Marshal.dump(bits)
else

  pixels       = Marshal.load File.read filename
  image_width  = pixels.first.length
  image_height = pixels.length

  results      = []
  num_widths   = 4
  start_width  = 25
  (start_width...start_width+num_widths).each do |char_width|
    char_height = char_width*2
    num_rows    = image_height / char_height
    num_cols    = image_width  / char_width

    chars = num_rows.times.map do |char_y|
      min_y = char_height*char_y

      num_cols.times.map do |char_x|
        min_x       = char_width*char_x
        char_pixels = (min_y...min_y+char_height).flat_map do |pixel_y|
          (min_x...min_x+char_width).map { |pixel_x| pixels[pixel_y][pixel_x] }
        end
        char_pixels.count(&:itself) / char_pixels.length.to_f
      end
    end

    [0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 0.95, 0.98].each do |threshold|
      content = "
        [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[],
        [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], ],[[],[],[],[], [],[],[],[],[],
        [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[],
        [],[],[],[],[], [],[] ],[[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[],
        [],[],[],[],[]] ,[ [],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[],
        [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[],
        [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[]], [[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[],
        [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[],
        [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[]],[
        [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[],
        [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], []], [[],[],[],
        [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[],
        [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], [],[],[],[],[],
        [],[],[],[],[], [],[],[],[],[], [],[],[],[],[], []])
      ".delete(" \n").chars.map(&:intern)

      ons_and_offs = chars.map do |row|
        row.map { |char| char > threshold }
      end

      holes_filled   = 0
      holes_unfilled = 0

      filled_in = ons_and_offs.map do |row|
        [*row, false].each_cons(2).map do |crnt_on, next_on|
          next_can_begin_a_line = (content[1] != :",")
          if crnt_on && (next_on || next_can_begin_a_line)
            if content.any?
              holes_filled += 1
            else
              holes_unfilled += 1
            end
            content.shift
          else
            :" "
          end
        end
      end

      num_holes            = holes_filled + holes_unfilled
      extra_holes          = holes_unfilled
      percent_extra_holes  = (100.0 * extra_holes / num_holes).to_i
      extra_pegs           = content.length
      num_pegs             = holes_filled + extra_pegs
      percent_extra_pegs   = (100.0 * extra_pegs / num_pegs).to_i
      code                 = filled_in.map(&:join).join("\n")
      threshold_percent    = (100.0*threshold).to_i
      distance_from_target = extra_holes + extra_pegs

      if distance_from_target < 100
        results << {
          distance_from_target:  distance_from_target,
          pixel_width_per_char:  char_width,
          pixel_height_per_char: char_height,
          threshold:             threshold_percent,

          percent_extra_holes:   percent_extra_holes,
          num_holes:             num_holes,
          holes_filled:          holes_filled,
          extra_holes:           extra_holes,

          percent_extra_pegs:    percent_extra_pegs,
          num_pegs:              num_pegs,
          extra_pegs:            extra_pegs,

          code:                  code,
        }
      end
    end
  end

  results.sort_by! { |r| r[:distance_from_target] }

  require 'pp'
  pp results
end
