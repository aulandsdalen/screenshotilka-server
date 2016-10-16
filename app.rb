require 'sinatra'
set :bind, '0.0.0.0'
set :views, settings.root + '/views'

get '/' do
	haml :index
end

get '/upload' do 
	haml :upload
end	