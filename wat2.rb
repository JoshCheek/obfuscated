# 1. Grab the Fixnum#inspect from the TextMate example and paste it into here
#    so you can see the intermediate bit values
# 2. Figure out where you can put parens in the below expression,
#    because they show you what you need to combine first (dependencies... ;P)
# 3. look at the next two lines and iteratively remove the maps

3.times.map { |n| 7 * n } # => [0, 7, 14]

puts "%c" * 3 % 3.times.map { |n| 1913079 >> ( 7 * n ) & 127 } + "?"

class Fixnum
  alias original_inspect inspect
  def inspect
    "#{to_s(2).rjust(8, '0')} (#{original_inspect})"
  end
end
