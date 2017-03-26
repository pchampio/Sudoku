require 'gtk3'
require 'yaml'
require 'thread'

require_relative '../class/board_class.rb'
require_relative '../class/cell_class.rb'
require_relative '../class/solver_class.rb'
require_relative './component_board.rb'
require_relative './component_inGame_menu.rb'
require_relative './component_cell.rb'
require_relative './serialisable.rb'
require_relative './route_libre_win.rb'


class FreeModeGame < Gtk::Frame

  def initialize(window,board)
    super()
    @window = window
    window.set_title "Sudoku (Jeu Libre)"
    window.set_window_position Gtk::WindowPosition::CENTER

    startTimer()

    hBox = Gtk::Box.new(:horizontal,2)
    boardComponent = BoardComponent.create board
    inGameMedu = InGameMenu.create(self, boardComponent)

    hBox.add(boardComponent)
    hBox.add(inGameMedu)
    self.add(hBox)

    show_all
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

	def victoire
		@window.remove self
		victoire = FreeModeWin.new(@window)
		@window.add(victoire)
	end

	def pause
		@window.remove self
		pause = Pause.new(@window)
		@window.add(pause)
	end
end
