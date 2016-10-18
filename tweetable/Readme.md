# Tweetable programs

Have to be short enough that they were able to be tweeted.


## [https://twitter.com/josh_cheek/status/765597818429935616](https://twitter.com/josh_cheek/status/773275486977822720)

This is the program `puts "wat"` written without letters, digits, quotes, spaces, parentheses, or brackets.
It only uses the chracters "$-./;<=>\`~", and is 91 characters in length.

```ruby
$ ruby -e '//=~$/;$;=$.-=~-~$.;$.<<=$.;$;=--~-$.<<-~-~$;;$>.<<$`<<$;--~-$.<<-~$;-$.-$.<<-~-~-~-~$;<<$/'
```


## [https://twitter.com/josh_cheek/status/788409635996700672](https://twitter.com/josh_cheek/status/788409635996700672)

This is the program `puts "Hello, Ruby! <3 <3 <3"`

```ruby
alias to_i putc
011031266154336260402447254236220440170314401703144017031412
.to_s(020).scan(/.{2}/){ |to_i| to_i to_i :: to_i 2 <<-~ 2 }
```


## [https://twitter.com/josh_cheek/status/760519587758690304](https://twitter.com/josh_cheek/status/760519587758690304)

This must be run in a terminal because it uses ANSI escape sequences to draw.
[Here](https://gist.github.com/JoshCheek/c2e999f3b306398f5bb6935ce9ac8b6b)'s
a bunch of intermediate versions, it took a a few hours to get short enough to tweet.

It's based on L-Systems, though shortened enough that it's not actually an L-System anymore.
[This](http://algorithmicbotany.org/papers/abop/abop-ch1.pdf) paper was really helpful for getting them done,
though I've got more notes and examples (including 3d ^^) [here](https://github.com/JoshCheek/hilbert-curve).

```sh
$ ruby -e 'r=1..4;3.times{r=r.flat_map{|n|[0,0,1,2,3,0,0].map{|m|n+m}}};$><<r.map{|n|"\e[42m  \e[2D\e[#{n%2*2}#{"ACBD"[n%4]}"*2}*""<<"\e[59H"'
```


## [https://twitter.com/josh_cheek/status/667501443226558464](https://twitter.com/josh_cheek/status/667501443226558464)

Another L-System, so also needs the terminal.

```sh
# Smaller version
$ ruby -e's=?F;3.times{s.gsub!?F,"F3F1F1F3F"};puts"\e[30H\e[47m#{s.gsub(/./){$.+=$&.to_i;"\e[#{%w[2C B 2D A][$.%4]}  \e[2D"*2if$&[?F]}}\e[m"'

# Big version (you'll have to increase num chars displayable on your terminal)
$ ruby -e's=?F;4.times{s.gsub!?F,"F3F1F1F3F"};puts"\e[90H\e[47m#{s.gsub(/./){$.+=$&.to_i;"\e[#{%w[2C B 2D A][$.%4]}  \e[2D"*2if$&[?F]}}\e[m"'
```
