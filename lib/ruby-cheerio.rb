require 'nokogiri'

class RubyCheerio
	attr_accessor :text, :html

	def initialize html=nil
		if valid_args? html
			if html.instance_of? Nokogiri::HTML::Document
				@html_nokogiri = html
			elsif html.instance_of? String and !html.empty?
				html = html.strip
				@html_nokogiri = Nokogiri::HTML(html)
			else
				raise EmptyHTMLError
			end
			@text = @html_nokogiri.text 
			@html = Nokogiri::HTML(@html_nokogiri.to_html).css('body').inner_html
		end
	end

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

	def valid_args? *args
		args.each do |arg|
			raise ArgumentError.new('Invalid Argument') if arg.nil? or (arg.instance_of? String and arg.strip.empty?)
		end
		return true
	end

end