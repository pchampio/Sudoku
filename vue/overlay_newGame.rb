require 'gtk3'
require 'thread'

Dir[File.dirname(__FILE__) + '/*.rb'].each {|file| require file }

class NewGame < Overlay

  attr_reader :board
  private_class_method :new

  def self.create(callFrom)
    new(callFrom)
  end

  def initialize(callFrom)
    @board = nil
    super()
    vBox = Gtk::Box.new(:vertical,10)
    hBox = Gtk::Box.new(:horizontal,10)

    title = Gtk::Label.new("<span weight='ultrabold' font='16'>Nouvelle partie</span>", :xalign=>0)
    title.use_markup = true
    vBox.pack_start(title, :expand=>false, :fill=>false, :padding=>15)

    if callFrom == :headerbar
      charge = Gtk::Button.new(:label=>"Annuler")
      charge.signal_connect("clicked"){
        Thread.kill(@job) if @job
        self.destroy
      }
      charge.style_context.add_class('destructive-action')
    else
      charge = Gtk::Button.new(:label=>"Charger la dernière partie")
      charge.signal_connect("clicked") do
        @board = Board.unserialized(File.dirname(__FILE__) + "/../save_board.yaml")
        self.destroy
      end
      charge.style_context.add_class('suggested-action')
    end

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
      vBox.remove(charge)
      charge.set_label("Annuler")
      charge.signal_connect('clicked') do
        Thread.kill(@job) if @job
        self.destroy
      end
      charge.style_context.add_class('destructive-action')
      vBox.pack_start(charge)
      self.show_all
      generate(:extreme)
    }
    vBox.pack_start(btnDia, :expand=>false, :fill=>false, :padding=>2)

    vBox.pack_start(Gtk::Label.new(""), :expand=>false, :fill=>false, :padding=>1) if callFrom == :end_game

    vBox.pack_start(charge, :expand=>false, :fill=>false, :padding=>15) unless callFrom == :end_game
    hBox.pack_start(vBox, :expand=>false, :fill=>false, :padding=>15)

    self.add hBox

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

