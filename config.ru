# frozen_string_literal: true

ENV['APP_ENV'] ||= 'development'
ENV['RACK_ENV'] = ENV['APP_ENV']

require 'rubygems'
require 'bundler'

Bundler.require :default, ENV['APP_ENV'].to_sym

require_relative 'app'
run NetfixTask3App
