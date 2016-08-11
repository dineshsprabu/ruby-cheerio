#Ruby Cheerio - jQuery styled HTML parser


##Installing the GEM
 
Use 'gem install ruby-cheerio' for adding it to your gem-list

You can add 'gem ruby-cheerio' to your Gemfile and run 'bundle install'.


##Sample Code



Adding ruby-cheerio to your code

```ruby

require 'ruby-cheerio'

```

jQuery is just a variable name here, This can be anything based on your requirement.

```ruby

jQuery = RubyCheerio.new("<html><body><h1 class='one'>h1_1</h1><h1>h1_2</h1></body></html>")


```

The .find method on a cheerio object can be passed with 'selectors' which can be a class, id, element name or all together.

```ruby

jQuery.find('h1').each do |head_one|
	p head_one.text
end

```

The .prop method can return the value of the attribute being passed. Here 'class' is the attribute needed and 'h1' is the selector again.

```ruby

p jQuery.find('h1.one')[0].prop('h1','class')

```

You can find some interesting sample code here: [Sample Code](tree/master/sample_code)
