Runnable
========

Playing with sprintf and percent string literals, posted on [Twitter](https://twitter.com/josh_cheek/status/658032347887996928)

```
$ ruby -e 'puts %);%s#$/o%%sO)%%%)%%%^_^'
;)
o_O
```

-----

Missing methods get printed. Their arguments are the ascii codes for space and newline. `$>` is stdout.

```
$ ruby -e 'def method_missing ond,emd,anb= %>><< emd ; $><< ond<<anb end and hello 010<<01<<1 and Ruby 10<<0'
hello Ruby
```

Variation

```
$ ruby -e 'def method_missing _,__=$><<%>>.<<(010<<01<<1);__<<_ end and o l l e h and y b u r and puts'
 hello ruby
```

Slightly obfuscated variation

```
$ ruby -e 'def method_missing _,__=$><<%>>.<<(010<<01<<1),& __end__;__.<<_,& __end__ end and o l l e h and y b u r and puts'
 hello ruby
```

Variation with obfuscation.

```
$ ruby -e 'def method_missing __,___=__==%s=o=?%= =:%,,,_=$>;_<<__<<___;IO end and h.e.l.l.o. R::u::b::y and puts'
hello Ruby
```

-----

Toplevel method definition puts `|` method on all objects.
We still have to return self, b/c putc returns an integer, which defines `|`, and is serached before `Object`.
`$>` is standard output, calling `putc` on it prints the letter of the associated ascii code.
`$.` stores the "current line number" when iterating over stdin,
which we aren't, so it's just a convenient way to store the previously printed ascii value, and it is conveniently initialized to 0.
Because we're storing the number previously printed, we pass offsets to the next number.
Tilde inverts the number's bits.

```
$ ruby -e 'public(def |(_) $>.putc $.+=_ and self end)|72|29|7|0|3|~66|~11|50|35|~18|23|-111'
Hello, Ruby
```

Same as above, just more obfuscated.

```
$ ruby -e 'public(def [](o) $><<%.#$_..<<($.+=o)&&self end)[72][29][7][0][3][~66][~11][50][35][~18][23].[]~110'
Hello, Ruby
```

Same as above, but uses a y combinator (though sgrif will point out that it's actually a [Z combinator](https://en.wikipedia.org/wiki/Fixed-point_combinator#Strict_fixed_point_combinator))

```
$ ruby -e '->y{->o{$>.putc($.+=o)&&y[y]}}[->y{->o{$>.putc($.+=o)&&y[y]}}][72][29][7][0][3][~66][~11][50][35][~18][23][-111]'
Hello, Ruby
```
