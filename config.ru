# frozen_string_literal: true

ENV['APP_ENV'] ||= 'development'
ENV['RACK_ENV'] = ENV['APP_ENV']

require 'rubygems'
require 'bundler'
require 'sinatra/base'
require 'sinatra/reloader' if ENV['APP_ENV'] == 'development'

Bundler.require :default, ENV['APP_ENV'].to_sym

Dir.glob('./app/{models,controllers}/*.rb').each { |file| require file }

map('/') { run WelcomeController }
