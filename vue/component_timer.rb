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
	attr_reader :elapse
	private_class_method :new
	def self.create(label)
		new(label)
	end
	def initialize(label)

    @pause = false
		@labelTime = label
		@elapse = 0
		#récupérer le temps dans la board et après enlever puis remettre le timer? pb avec affichage timer et méthode
		@time= Thread.new do
			while true do
        @labelTime.set_markup("<b> #{getTimeFromSec} </b>")
        sleep(1)
				@elapse += 1
        Thread.stop if @pause
				getTimeFromSec(@elapse)
        @labelTime.set_markup("<b> #{getTimeFromSec}</b>")
			end
			@time.join
			@pause.join
		end
    return @time
	end

	def stopTimer()
		@time.kill
    return getTimeFromSec
	end

	def getTimeFromSec(time=@elapse)
		@minute = format('%02d', time/60)
		@sec = format('%02d', time%60)
		@timeFin  = "#{@minute}:#{@sec}"
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
