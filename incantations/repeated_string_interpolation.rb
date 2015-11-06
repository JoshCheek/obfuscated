def format_string_for(string, format_style=:bit_shift)
  # note "hello, Ruby" is 11 chars, so num_percents is ~-(1<<11)
  # and  "<3 Ruby" is 7 chars, which could be represented with ~-(1<<~-(1<<~-(1<<1<<1)))
  percent_char     = '(1|1<<(1<<1<<1)<<1|1<<1<<1).chr' # (1|32|4).chr # => 37.chr # => "%"
  num_percents     = "~-(1<<#{string.length})"         # this is just a fancy 2**string.length
  bit_shift_format = %("\#{#{percent_char}*#{num_percents}}s")

  # several possibilities
  simple_format = %("\#{'%'*#{2**string.length-1}}s") # => "\"\#{'%'*127}s\""
  simple_format = "(?%*#{2**string.length-1}+?s)"     # => "(?%*127+?s)"
  simple_format = "('%'*#{2**string.length-1}+?s)"    # => "('%'*127+?s)"

  format_style == :bit_shift ? bit_shift_format : simple_format
end

def sprintfs_for(string)
  *first_chars, last_char = string.chars.reverse
  sprintf_operator        = '%'
  first_sprintfs          = first_chars.map { |c| sprintf_operator + "\"s#{c}\"" }.join
  last_sprintf            = '%' + %'"#{last_char}"'
  first_sprintfs << last_sprintf
end

def swap_string_literal(str, open_delimiter, close_delimiter=open_delimiter)
  str.gsub(/"(.*?)"/) { "%#{open_delimiter}#{$1}#{close_delimiter}" }
end

def eval_capturing_stdout(code)
  require 'stringio'
  real_stdout, $stdout = $stdout, StringIO.new
  eval code
  $stdout.string
ensure
  $stdout = real_stdout
end


string        = "<3 Ruby"
format_string = format_string_for string, :simple # => "('%'*127+?s)"
sprintfs      = sprintfs_for string      # => "%\"sy\"%\"sb\"%\"su\"%\"sR\"%\"s \"%\"s3\"%\"<\""

swap_string_literal sprintfs, '(', ')' # => "%%(sy)%%(sb)%%(su)%%(sR)%%(s )%%(s3)%%(<)"
swap_string_literal sprintfs, ')', ')' # => "%%)sy)%%)sb)%%)su)%%)sR)%%)s )%%)s3)%%)<)"
swap_string_literal sprintfs, '!'      # => "%%!sy!%%!sb!%%!su!%%!sR!%%!s !%%!s3!%%!<!"
swap_string_literal sprintfs, '?'      # => "%%?sy?%%?sb?%%?su?%%?sR?%%?s ?%%?s3?%%?<?"
swap_string_literal sprintfs, '%'      # => "%%%sy%%%%sb%%%%su%%%%sR%%%%s %%%%s3%%%%<%"

puts code = swap_string_literal("puts #{format_string}#{sprintfs}", '%')
eval_capturing_stdout code # => "<3 Ruby\n"

# >> puts ('%'*127+?s)%%%sy%%%%sb%%%%su%%%%sR%%%%s %%%%s3%%%%<%
