# Invoke like this: "

require "io/console"
text = ARGV.join(" ").split(/\b/).flat_map.with_index(0) do |word, index|
  word.chars.map { |char| "\e[9#{index%7+1}m#{char}" }
end + (" "*10).chars

include Math
print "\e[H\e[2J\e[?25l"
at_exit { print "\e[#{$stdout.winsize[0]-2}H\e[A\e[?25h" }
radius = text.length / 2 / PI
ø = 2 * PI / text.length
loop.with_index do |*, cursor|
  text.each.with_index -cursor do |c, i|
    y = sin(ø*i - PI/2)*radius   + radius   + 1
    x = cos(ø*i - PI/2)*radius*2 + radius*2 + 1
    print "\e[#{y.floor};#{x.floor}H#{c}"
  end
  sleep 0.1
end
