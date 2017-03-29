#!/usr/bin/env ruby

# encoding: UTF-8

##
# Author:: CHAMPION Pierre
# License:: MIT Licence
#
# https://github.com/Drakirus/Sudoku
#

require 'gtk3'

class Overlay < Gtk::Overlay

  def initialize(main_window)
  	super()
    @main_window = main_window
    self.init_ui()
  end

  def init_ui

    @frame = Gtk::Frame.new
    
    self.add_overlay(@frame)
    self.set_overlay_pass_through(@frame, false)
   

    @frame.name = "wind"

    css=<<-EOT
     #wind {
      background-color: #282727;
      opacity: 0.7;
     }
    EOT


	css_provider = Gtk::CssProvider.new
	css_provider.load :data=>css
	apply_css(@frame, css_provider)

    @main_window.add(self)
    self.show_all
  end

  def update
 
  end

  def addComponent(element)
  	@frame.add(element)
  end
 
  def run
    if !@main_window.visible?
      @main_window.show_all
    else
      @main_window.destroy
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
end

#window = Gtk::Window.new("First example")
#window.set_size_request(400, 400)
#window.set_border_width(10)
#
#window.signal_connect("delete-event") { |_widget| Gtk.main_quit }
#
#Overlay.new(window).run
#Gtk.main