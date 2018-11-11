require 'ripper'


body  = File.read(ARGV.fetch 0).lines.last.chomp
chars = body.chars.uniq.sort
exprs = Ripper.sexp(body)[1]

puts "length:         #{body.length}"
puts "expressions:    #{exprs.size}"
puts "alphabet_arity: #{chars.size}"
puts "alphabet:       #{chars.join}"
