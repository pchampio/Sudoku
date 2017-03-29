require 'gtk3'
class OverlayDemo
  def initialize(main_window)
    @window = Gtk::Window.new(:toplevel)
    @window.set_default_size(500, 510)
    @window.title = "Interactive Overlay"
    @window.screen = main_window.screen

    @overlay = Gtk::Overlay.new
    initialize_grid
    @overlay.add(@grid)

    @entry = Gtk::Entry.new
    @entry.placeholder_text = "Your Lucky Number"

    vbox = Gtk::Box.new(:vertical, 10)
    @frame = Gtk::Frame.new

    @overlay.add_overlay(@frame)
    @frame.add vbox
    @overlay.set_overlay_pass_through(@frame, false)
    vbox.halign = :center
    vbox.valign = :center

    button = Gtk::Button.new(:label =>"coucou")
    button.name = "buttontest"
    vbox.add button

    button.signal_connect "clicked" do
      @overlay.remove(@frame)
    end

    @frame.name = "wind"

    css=<<-EOT
     #wind {
      background-color: #282727;
      opacity: 0.7;
     }
    #buttontest{
      background-color: #f20000;
    }
    EOT


  css_provider = Gtk::CssProvider.new
  css_provider.load :data=>css
  apply_css(@frame, css_provider)


  vbox.pack_start(@entry, :expand => false, :fill => false, :padding => 8)

    @window.add(@overlay)
    @overlay.show_all
  end

  def run
    if !@window.visible?
      @window.show_all
    else
      @window.destroy
    end
  end

  private

  def initialize_grid
    @grid = Gtk::Grid.new
    (0..4).each do |i|
      (0..4).each do |j|
        text = (5 * j + i).to_s
        button = Gtk::Button.new(:label => text)
        button.hexpand = true
        button.vexpand = true
        button.signal_connect "clicked" do |widget|
          @entry.text = widget.label
        end
        @grid.attach(button, i, j, 1, 1)
      end
    end
  end
end


def apply_css(widget,provider)
  widget.style_context.add_provider provider, Gtk::StyleProvider::PRIORITY_USER
  if(widget.is_a?(Gtk::Container))
    widget.each_all do |child|
      apply_css(child,provider)
    end
  end
end

window = Gtk::Window.new("First example")
window.set_size_request(400, 400)
window.set_border_width(10)

window.signal_connect("delete-event") { |_widget| Gtk.main_quit }

OverlayDemo.new(window).run
Gtk.main