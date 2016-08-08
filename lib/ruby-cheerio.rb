require 'nokogiri' # Nokogiri is 

class RubyCheerio

	# This creates an attribute readers and writers needed for the instance 
	# variables.

	attr_accessor :text, :html

	# This method defines the instance of a RubyCheerio object with attributes 
	# like text, html and if an argument is not passed, it throws an ArgumentError
	def initialize html=nil
		if valid_args? html
			if html.instance_of? Nokogiri::HTML::Document
				@html_nokogiri = html
			elsif html.instance_of? String and !html.empty?
				html = html.strip
				@html_nokogiri = Nokogiri::HTML(html)
			end
			@text = @html_nokogiri.text 
			@html = Nokogiri::HTML(@html_nokogiri.to_html).css('body').inner_html
		end
	end

	# This method can find an element using element-name, class-name, id-name or 
	# all together. This works like finding elements using jQuery styled selectors.

	def find selector=nil
		if valid_args? selector
			elements_list = @html_nokogiri.css(selector).to_a.map{|e| self.class.new(e.to_html)}
			if !elements_list.nil?
				return elements_list
			else
				return nil
			end
		end
	end

	# This method can return the property of an element, which is selected using the 
	# selector being passed.

	def prop(selector, attribute)
		if valid_args?(selector, attribute)
			element = @html_nokogiri.css(selector)
			if element.instance_of? Nokogiri::XML::NodeSet
				return element[0][attribute]
			elsif element.instance_of? Nokogiri::XML::Element
				return element[attribute]
			else
				return nil
			end
		end
	end

	private

	# This is a private method used to validate the argument being passed.

	def valid_args? *args
		args.each do |arg|
			raise ArgumentError.new('Invalid Argument') if arg.nil? or (arg.instance_of? String and arg.strip.empty?)
		end
		return true
	end

end