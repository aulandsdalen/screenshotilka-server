#\ -p 4567
require './app'
use Rack::Reloader

run Sinatra::Application