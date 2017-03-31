require 'gtk3'
require 'thread'

class NewGame < Gtk::Box
  attr_reader :board
  def initialize()
    @board = nil
    super(:vertical,10)

    btnEz = Gtk::Button.new(:label=>"Facile")
    btnEz.signal_connect("clicked"){
      generate(:easy)
    }
    self.add btnEz

    btnMo = Gtk::Button.new(:label=>"Moyen")
    btnMo.signal_connect("clicked"){
      generate(:medium)
    }
    self.add btnMo

    btnDu = Gtk::Button.new(:label=>"Dur")
    btnDu.signal_connect("clicked"){
      generate(:hard)
    }
    self.add btnDu

    btnDia = Gtk::Button.new(:label=>"Diablique")
    btnDia.signal_connect("clicked"){
      generate(:extreme)
    }
    self.add btnDia

    anul = Gtk::Button.new(:label=>"Anuler")
    anul.signal_connect("clicked"){
      Thread.kill(@job) if @job
      self.destroy
    }
    anul.style_context.add_class('destructive-action')
# suggested-action

    self.add anul

  end

  def signal_retour
		self.signal_connect("destroy") do
      yield
    end
  end

  def generate(lvl)
    gen=Generator.new
    self.parent.parent.parent.load_cursor
    @job = Thread.new do
      @board = gen.generate(lvl)
      self.destroy
    end
  end
end

