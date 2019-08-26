# frozen_string_literal: true

ENV['APP_ENV'] ||= 'development'
ENV['RACK_ENV'] = ENV['APP_ENV']

require 'rubygems'
require 'bundler'
require 'sinatra/base'

Bundler.require :default, Sinatra::Base.environment

Dir.glob('./app/{models,controllers}/*.rb').each { |file| require file }
