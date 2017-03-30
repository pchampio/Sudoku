#!/usr/bin/env ruby

# encoding: UTF-8

##
# Author:: Waibin Wang, Riviere Marius, Pierre CHAMPION
# License:: MIT Licence
#
# https://github.com/Drakirus/Sudoku

def apply_css(widget,provider)
  widget.style_context.add_provider provider, Gtk::StyleProvider::PRIORITY_USER
  if(widget.is_a?(Gtk::Container))
    widget.each_all do |child|
      apply_css(child,provider)
    end
  end
end

def apply_style(widget, css)
  css_provider = Gtk::CssProvider.new
  css_provider.load :data=>css
  apply_css(self, css_provider)
end

def apply_css_color_button(object, cssTarget, color)
    red = (color.red / 65535.0) * 255.0
    green = (color.green / 65535.0) * 255.0
    blue = (color.blue / 65535.0) * 255.0
    css=<<-EOT
    button{
      #{cssTarget}: rgb(#{red},#{green},#{blue});
    }
    EOT
    css_provider = Gtk::CssProvider.new
    css_provider.load :data=>css
    apply_css(object,css_provider)
end
