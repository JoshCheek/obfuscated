puts( (code = <<quine)[/\A.*$/] , code , 'quine' )
puts( (code = <<quine)[/\\A.*$/] , code , 'quine' )
printf a="%1$s a=%2$s , '%1$s' , a.inspect" , 'printf' , a.inspect
quine
