require 'rubygems'
require 'twitter'
class AnujaTwitter
	attr_accessor :client
	def initialize
		@client = initiliaze_client
	end

	def initiliaze_client
		Twitter::REST::Client.new do | config |
			config.consumer_key        = "7J9MjAYUYbpf4mc8UG5pWxVOR"
			config.consumer_secret     = "iaxi2QIgjB73Ci6EASSUZtA8U4JL6j3Ame135avXpiFOAy2oJh"
			config.access_token        = "1094868015282352128-Xh8WYFp8c0mmXVA1KQyUaVk0RHNq0y"
			config.access_token_secret = "ZLTW359tquwZAbOBIkd61atJmvdsWDvBNNL0rFlNFRkj8"
		  end
	end
end

