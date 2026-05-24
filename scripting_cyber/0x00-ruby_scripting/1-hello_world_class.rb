Write a Ruby script that prints "Hello, World!" using a class.

    Class HelloWorld
        Use method that sets an instance
            create variable called message that hold the string Hello, World!
        Create a method that display the message called print_hello

┌──(imen㉿hbtn-lab)-[…/scripting_cyber/0x00-ruby_scripting]
└─$ cat 1-main.rb 
require_relative '1-hello_world_class'

# Create an instance of HelloWorld, change the message, and call the print_hello method
hello_world_instance = HelloWorld.new

hello_world_instance.print_hello

┌──(imen㉿hbtn-lab)-[…/scripting_cyber/0x00-ruby_scripting]
└─$ ruby 1-main.rb 
Hello, World!
