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
   attr_accessor :elapse
	private_class_method :new
	def self.create(label)
		new(label)
	end
	def initialize(label)

    @pause = false
		@labelTime = label
		@elapse = 0
		@time= Thread.new do
			while true do
        sleep(1)
				@elapse += 1
        Thread.stop if @pause
        @labelTime.set_markup("<b> #{getTimeFromSec}</b>")
			end
			@time.join
			@pause.join
      @elapse.join
		end
    return @time
	end

	def stopTimer()
		@time.kill
    return getTimeFromSec
	end

  def getTimeFromSec(time=@elapse)
    return Timer.getTimeFromSec(time)
  end

	def self.getTimeFromSec(time)
		@minute = format('%02d', time/60)
		@sec = format('%02d', time%60)
		@timeFin  = "#{@minute}:#{@sec}"
		return @timeFin
	end

	def self.getTimeAccueil(time)
		@heure = format('%2d', time/3600)
		@min = format('%2d', time/60)
		#@timeFin  = "#{@heure} heure#{s if(@heure.to_i>0)} et #{@min} minute#{s if(@min.to_i>0)}"
		@timeFin  = "#{@heure} heure et #{@min} minute"
		return @timeFin
	end

	def toggle
    @pause = !@pause
    if @time.status =='sleep'
      @time.run
    end
	end

  def running
    @pause
  end

  def raz
    @elapse = 0
  end

end
