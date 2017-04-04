require 'gtk3'
require 'thread'

class NewGame < Gtk::Frame
  attr_reader :board
  def initialize()
    @board = nil
    super()
    vBox = Gtk::Box.new(:vertical,10)
    hBox = Gtk::Box.new(:horizontal,10)

    title = Gtk::Label.new("<span weight='ultrabold' font='16'>Nouvelle partie</span>", :xalign=>0)
    title.use_markup = true
    vBox.pack_start(title, :expand=>false, :fill=>false, :padding=>15)

    btnEz = Gtk::Button.new(:label=>"Facile")
    btnEz.signal_connect("clicked"){
      generate(:easy)
    }
    vBox.pack_start(btnEz, :expand=>false, :fill=>false, :padding=>2)

    btnMo = Gtk::Button.new(:label=>"Moyen")
    btnMo.signal_connect("clicked"){
      generate(:medium)
    }
    vBox.pack_start(btnMo, :expand=>false, :fill=>false, :padding=>2)

    btnDu = Gtk::Button.new(:label=>"Dur")
    btnDu.signal_connect("clicked"){
      generate(:hard)
    }
    vBox.pack_start(btnDu, :expand=>false, :fill=>false, :padding=>2)

    btnDia = Gtk::Button.new(:label=>"Diabolique")
    btnDia.signal_connect("clicked"){
      generate(:extreme)
    }
    vBox.pack_start(btnDia, :expand=>false, :fill=>false, :padding=>2)

    anul = Gtk::Button.new(:label=>"Annuler")
    anul.signal_connect("clicked"){
      Thread.kill(@job) if @job
      self.destroy
    }
    anul.style_context.add_class('destructive-action')
    # suggested-action


    vBox.pack_start(anul, :expand=>false, :fill=>false, :padding=>15)
    hBox.pack_start(vBox, :expand=>false, :fill=>false, :padding=>15)

    self.add hBox

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

