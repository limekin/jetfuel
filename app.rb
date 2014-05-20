class Configuration < Sinatra::Base

	configure do

		enable :sessions
		enable :method_override
		set :public_folder, Dir.pwd + "/assets"
		
	end

end

module Routes

	class Login < Sinatra::Base


		get '/login' do
		end

		get '/logout' do 
		end

		get '/signup' do
		end


	end

	class Basic <  Sinatra::Base

		before do
		end

		get '/' do
		end

		get '/:url_hash' do
		end

		post '/shorten' do
		end
	end

end

class JetFuel < Sinatra::Base

	use Configuration
	use Routes::Login
	use Routes::Basic


end
