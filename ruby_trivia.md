Candidates I'm submitting to [sferik](https://twitter.com/sferik)'s Ruby Trivia

* [Ruby Trivia 1](https://speakerdeck.com/sferik/ruby-trivia)
* [Ruby Trivia 2](https://speakerdeck.com/sferik/ruby-trivia-2)
* [Collaborate?](https://twitter.com/sferik/status/662677213758824448)

-----

* `$ ruby -ne ''` what methods will be available that aren't normally?
* `1 if //` vs `1 if ""` Bonus: how can you change what the first expression evalutes to?
* `print` vs `print` Bonus: How can you change what the first expression does?
* Regex setting locals
* Binding is top of stack
* 3 ivars, they'll be stored directly on the object
* rescue on runtime, not all exceptions
* `ruby -e 'x=y=false; p(y ?x :x)'` Now delete either the `x=` or the `y=` (or both) (got this one from Yusuke Endoh)
* `if (a=1); a; end` vs `1 if a=1`
* `a+=1` vs `a||a=1` vs `a=a||1`
* Shadow variables
* in main, methods are declared privately on Object
* class vars
* `T_ICLASS`
* system prints to the process's actual stdout, so `$stdout=STDOUT=File.open("something")` won't stop it from printing
* Constants with lowercase first letters (eg fatal)
* `NameError::message`
* `Queue.new.shift` fastest deadlock? Also, the fact that it can tell you it's deadlocked means what?
* Globals you can't assign to, eg `$_ = ""` vs `$1 = ""`, and `$* = ['a']` (note that one is a SyntaxError, other a NameError)
* Mutex vs Monitor
* `a="a"; def a.b;end` vs `def "a".b;end`
* What does each `self` evaluate to?

  ```ruby
  class << class << class << Class
    self
  end
    self
  end
    self
  end
  ```
* `A B`, syntactically, `A` is a method, `B` is a constant
* What will this code do? `class BasicObject; Object; end`
* What does this code evaluate to? `Class.singleton_class.superclass.superclass.superclass.superclass`
