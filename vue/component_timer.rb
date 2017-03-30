#!/usr/bin/env ruby

# encoding: UTF-8

##
# Author:: DEZERE Florian, BIARDEAU Tristan
# License:: MIT Licence
#
# https://github.com/Drakirus/Sudoku
#

require 'thread'

class Timer

	private_class_method :new
	def self.create(label)
		new(label)
	end
	def initialize(label)
		@labelTime = label
		@elapse = 0
		@time= Thread.new do
			while(true) do
				@elapse += 1
				sleep(1)
				getTimeFromSec(@elapse)
				@labelTime.set_markup("<b>#{getTimeFromSec}</b>")
			end
			@time.join
		end
	end

	def stopTimer()
		@time.kill
	end

	def getTimeFromSec(time=@elapse)
		@minute = format('%02d', time/60)
		@sec = format('%02d', time%60)
		@timeFin  = "#{@minute}:#{@sec}"
		return @timeFin
	end

	def pause
		@time.stop
	end

end
