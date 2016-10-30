# -p 4567 -o 0.0.0.0
require 'rubygems'
require 'sinatra'
require File.expand_path '../app.rb', __FILE__

run Sinatra::Application