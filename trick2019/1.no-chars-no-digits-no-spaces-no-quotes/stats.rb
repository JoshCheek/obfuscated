# you may need to `gem install parser`
require 'parser/ruby25'

body  = File.read(ARGV.fetch 0).chomp
chars = body.chars.uniq.sort

puts "length:         #{body.length}"
puts "alphabet_arity: #{chars.size}"
puts "alphabet:       #{chars.join.inspect}"
puts "expressions:    #{Parser::Ruby25.parse(body).children.size}"
