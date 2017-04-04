#!/usr/bin/env ruby

# encoding: UTF-8

##
# Author:: DEZERE Florian
# License:: MIT Licence
#
# https://github.com/Drakirus/Sudoku
#

require 'gtk3'

class SaveUser
	attr_reader :username, :time, :nbEtoile
	@@username = "Robert"
	def initialize()
		@username         = @@username
		@time             = @@time
		@nbEtoile         = @@nbEtoile
	end

	def self.setTime(time)
		@@time = time
	end

	def self.getTime()
		return @@time
	end

	def self.addEtoile(nbEtoile)
		@@nbEtoile = @@nbEtoile + nbEtoile
	end

	def self.getNbEtoile()
		return @@nbEtoile
	end

	def self.setNbEtoile(nbEtoile)
		@@nbEtoile = nbEtoile
	end

	def self.setUsername(username)
		@@username = username
	end

	def self.getUsername()
		return @@username
	end

	def self.serialized
		obj = GlobalOpts.new
		File.open(File.dirname(__FILE__) +"/../save_user.yaml", "w+") do |f|
			YAML.dump(obj, f)
		end
	end

	def self.load
		obj = YAML.load_file(File.dirname(__FILE__) +"/../save_user.yaml")
		self.setUsername(obj.username)
		self.setTime(obj.time)
		self.setNbEtoile(obj.nbEtoile)
	end
end