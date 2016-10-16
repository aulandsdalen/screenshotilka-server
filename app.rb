require 'sinatra'
set :bind, '0.0.0.0'
set :views, settings.root + '/views'
get '/' do
	haml :index
end

get '/upload' do 
	haml :upload
end	

post '/upload' do
	if params['up_image'][:type] != "image/png"
		return "File type error... only image/png's are allowed"
	end
	filename = 'public/'+params['up_image'][:filename]
	File.open('public/' + params['up_image'][:filename], 'w') do |f|
		f.write(params['up_image'][:tempfile].read)
	end
	return filename
end

get '/image/:filename' do
	if (File.exist?('public/' + params[:filename] + '.png'))
		haml :image, :locals => {:image => '/' + params[:filename] + '.png'}
	else
		"No such image"
	end
end