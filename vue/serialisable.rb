require 'gtk3'

class Serialisable

  attr_reader :selectColor, :backgroundColor, :chiffreColor

	def initialize()
	    @backgroundColor =  @@backgroundColor.to_s
	    @selectColor     =  @@selectColor.to_s
	    @chiffreColor	 =	@@chiffreColor.to_s
	end

	def self.getBackgroundColor()
		return @@backgroundColor
	end

	def self.setBackgroundColor(backgroundColor)
		@@backgroundColor = backgroundColor
	end

	def self.getSelectColor()
		return @@selectColor
	end

	def self.setSelectColor(selectColor)
		@@selectColor = selectColor
	end

	def self.getChiffreColor()
		return @@chiffreColor
	end

	def self.setChiffreColor(chiffreColor)
		@@chiffreColor = chiffreColor
	end

	def self.serialized
    obj = Serialisable.new
		File.open("save_color.yaml", "w+") do |f|
      YAML.dump(obj, f)
		end
	end

	def self.load
    obj = YAML.load_file("save_color.yaml")
   	self.setBackgroundColor(Gdk::Color.parse(obj.backgroundColor))
    self.setSelectColor(Gdk::Color.parse(obj.selectColor))
	self.setChiffreColor(Gdk::Color.parse(obj.chiffreColor))
	end

end