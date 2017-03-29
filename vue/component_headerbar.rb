require "gtk3"

class HeaderbarDemo

    private_class_method :new
    def self.create(main_window)
      new(main_window)
    end

  def initialize(main_window)

    header = Gtk::HeaderBar.new
    header.show_close_button = true
    header.title = "Welcome to Facebook - Log in, sign up or learn more"
    header.has_subtitle = false

    button = Gtk::Button.new

    icon = Gio::ThemedIcon.new("mail-send-receive-symbolic")
    image = Gtk::Image.new(:icon => icon, :size => :button)

    button.add(image)
    header.pack_end(button)

    box = Gtk::Box.new(:horizontal, 0)
    box.style_context.add_class("linked")

    button = Gtk::Button.new
    image = Gtk::Image.new(:icon_name => "pan-start-symbolic", :size => :button)
    button.add(image)
    box.add(button)

    button = Gtk::Button.new
    image = Gtk::Image.new(:icon_name => "pan-end-symbolic", :size => :button)
    button.add(image)
    box.add(button)

    header.pack_start(box)
    main_window.titlebar = header
  end
end