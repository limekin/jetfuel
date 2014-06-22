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

			haml :login
		end

		get '/logout' do 
		end

		get '/signup' do

			haml :signup
		end


	end

	class Basic <  Sinatra::Base

		before do
		end

		get '/' do

			haml :home

		end

		get '/popular_urls' do 

			haml :popular_urls
		end

		get '/my_urls' do

			haml :my_urls
		end

		get '/:vanity/:url_hash' do
		end

		get '/failure' do 

			@message = params[:message]

			haml :failure
		end

		post '/shorten' do

			haml :result
		end
	end

end

class JetFuel < Sinatra::Base

	use Configuration
	use Routes::Login
	use Routes::Basic


end
