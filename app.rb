require 'sinatra'
require 'digest/md5'
require 'json'

set :bind, '0.0.0.0'
set :views, settings.root + '/views'
set :version, "git " + `git rev-parse --short HEAD`.chomp
set :url, "localhost"
set :upload_dir, "/upload"

get '/' do
	haml :index
end

get '/upload' do 
	haml :upload
end	

post '/upload' do
	response = {
		:filename => nil, #accessible file name
		:code => nil, #response code as in HTTP
		:message => nil #human-readable
	}
	if params['up_image'][:type] != "image/png"
		response[:code] = 415 # Unsupported Media Type
		response[:message] = "Invalid image type. Only image/png is supported"
		return response.to_json
	end
	filename = Digest::MD5.hexdigest(File.read(params['up_image'][:tempfile])) + ".png"
	File.open('public/'+filename, 'w') do |f|
		f.write(params['up_image'][:tempfile].read)
	end
	response[:filename] = filename
	response[:code] = 200 #OK
	response[:message] = "Image was successfully uploaded"
	return response.to_json
end

get '/image/:filename' do
	if (File.exist?('public/' + params[:filename] + '.png'))
		haml :image, :locals => {:image => '/' + params[:filename] + '.png'}
	else
		"No such image"
	end
end

get '/info' do
	response = {
		:version => settings.version,
		:url => settings.url, 
		:upload_dir => settings.upload_dir,
		:server_name => nil
	}
	response.to_json
end