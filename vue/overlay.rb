require 'gtk3'

# class abstraite pour la gestion des Overlays
class Overlay < Gtk::Frame

  private_class_method :new
  def initialize
    super()
  end

  def signal_retour
    self.signal_connect("destroy") do
      yield
    end
  end

end

