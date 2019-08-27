# frozen_string_literal: true

ENV['APP_ENV'] ||= 'development'
ENV['RACK_ENV'] = ENV['APP_ENV']

require 'rubygems'
require 'bundler'
require 'sinatra/base'

Bundler.require :default, Sinatra::Base.environment

Dir.glob('./app/{models,services,controllers}/*.rb').each { |file| require file }

Pony.options = {
  from: "Netfix task3 <#{ENV['SMTP_U']}>",
  via: test? ? :test : :smtp,
  via_options: {
    enable_starttls_auto: true,
    authentication: :plain,
    port: 587,
    address: 'smtp.gmail.com',
    user_name: ENV['SMTP_U'],
    password: ENV['SMTP_P']
  }
}
