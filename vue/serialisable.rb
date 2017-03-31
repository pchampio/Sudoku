#!/usr/bin/env ruby

# encoding: UTF-8

##
# Author:: DEZERE Florian
# License:: MIT Licence
#
# https://github.com/Drakirus/Sudoku
#

require 'gtk3'

class GlobalOpts

  attr_reader :selectColor, :backgroundColor, :chiffreColor, :surligneColor

@@backgroundColor  = "#757550507b7b"
@@selectColor      = "#72729f9fcfcf"
@@chiffreColor     = "#ffffffffffff"
@@surligneColor    = "#ffffffffffff"
@@username         = "testuser"
@@erreurAutoriser  = false
@@surlignageSurvol = true

	def initialize()
	    @backgroundColor  = @@backgroundColor.to_s
	    @selectColor      = @@selectColor.to_s
	    @chiffreColor     = @@chiffreColor.to_s
	    @surligneColor    = @@surligneColor.to_s
	    @username         = @@username
	    @erreurAutoriser  = @@erreurAutoriser
	    @surlignageSurvol = @@surlignageSurvol
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

	def self.getSurligneColor()
		return @@surligneColor
	end

	def self.setSurligneColor(surligneColor)
		@@surligneColor = surligneColor
	end

	def self.setUsername(username)
		@@username = username
	end

	def self.getUsername()
		return @@username
	end

	def self.setErreurAutoriser(boolean)
		@@erreurAutoriser = boolean
	end

	def self.getErreurAutoriser()
		return @@erreurAutoriser
	end

	def self.setSurlignageSurvol(boolean)
		@@surlignageSurvol = boolean
	end

	def self.getSurlignageSurvol()
		return @@surlignageSurvol
	end

	def self.serialized
    obj = GlobalOpts.new
		File.open("save_color.yaml", "w+") do |f|
      YAML.dump(obj, f)
		end
	end

	def self.load
    obj = YAML.load_file("save_color.yaml")
   	self.setBackgroundColor(Gdk::Color.parse(obj.backgroundColor))
    self.setSelectColor(Gdk::Color.parse(obj.selectColor))
	self.setChiffreColor(Gdk::Color.parse(obj.chiffreColor))
	self.setSurligneColor(Gdk::Color.parse(obj.selectColor))
	#self.setUsername(obj.username) #peut y avoir des erreurs
	#self.setErreurAutoriser(obj.erreurAutoriser)
	#self.setSurlignageSurvol(obj.surlignageSurvol)
	end

end
