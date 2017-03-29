require 'gtk3'
require 'yaml'
require 'thread'


Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

class Game < Gtk::Frame

  def initialize(window,board)
    super()

    # create headerbar
    HeaderbarDemo.create window

    startTimer()

    hBox = Gtk::Box.new(:horizontal,2)
    boardComponent = BoardComponent.create board
    inGameMedu = InGameMenu.create(self, boardComponent)

    hBox.add(boardComponent)
    hBox.add(inGameMedu)
    self.add(hBox)
  end

  def startTimer()
    @elapse = 0
    @time= Thread.new do
      while(true) do
        @elapse += 1
        sleep(1)
        getTimeFromSec(@elapse)
      end
      @time.join

    end
  end

  # stopTimer()
  # puts "avant"
  # puts @timeFin
  # puts "apres"
  def stopTimer()
    @time.kill
  end

  def getTimeFromSec(time)
    @minute = format('%02d', time/60)
    @sec = format('%02d', time%60)

    # print "#{@minute}:#{@sec} \n"
    @timeFin  = "#{@minute}:#{@sec}"
  end


  def pause
    @time.stop
  end

end
