
## Disclaimer: This code should be used only for educational puroposes.
## Author: Dineshprabu S

require 'ruby-cheerio' # 'gem install ruby-cheerio' for using this.
require 'rest-client' # 'gem install rest-client' for using this.

## getGemInfo returns a consolidated hash of gems with name, version, download_count
## using RubyCheerio jQuery style HTML Parser.

def getGemInfo page_no

	# RubyCheerio object created with HTML String returned from RestClient.
	jQuery = RubyCheerio.new( (RestClient.get "https://rubygems.org/gems?page=#{page_no.to_s}").to_str )
	ruby_gems = Array.new

	# Finds the gem block
	jQuery.find('.gems__gem').each do |gem_info|
		# Finds the name inside gem block
		gem_name_version = gem_info.find('h2.gems__gem__name')[0].text.strip.split("\n")

		# Finds the download count inside gem block
		gem_downloads = gem_info.find('p.gems__gem__downloads__count')[0].text.strip.split("\n")[0]

		# Adds it to hash
		ruby_gems << { name: gem_name_version[0].strip, version: gem_name_version[1].strip, downloads: gem_downloads }
	end
	ruby_gems
end

# Prints the gem information hash for page 1.
p getGemInfo 1
