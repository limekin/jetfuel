class Configuration < Sinatra::Base

	configure do

		enable :sessions
		enable :method_override
		set :public_folder, Dir.pwd + "/assets"
		
	end

end

module Routes

	class Auth < Sinatra::Base


		helpers do

			def authenticate(user_data)

				unless user_data[:username] and user_data[:password]
					redirect to("/signin")
				end

				user = User.first(:username => user_data[:username], :password => user_data[:password])

				if user
					session[:user] = user
				else
					redirect to('/signin')
				end

				redirect to('/')

			end

			def add_user(user_data)

				redirect to('/signup') unless user_data[:password].eql? user_data[:confirm_pass]
				puts 'hohho'

				user = User.new
				user.username = user_data[:username]
				user.password = user_data[:password]
				if user.save
					redirect to("/signin")
				else
					redirect to("/signup")
				end
				
			end


		end

		before do

			session[:user] = User.first(:username => "anonymous") unless session[:user]
			@user = session[:user]

		end
		get '/signin' do

			haml :signin
		end

		get '/signout' do 

			session[:user] = nil
			redirect to("/")

		end

		get '/signup' do

			haml :signup
		end

		post '/signup' do
		
			add_user(params[:user])

		end

		post '/signin' do

			authenticate(params[:user])

		end




	end

	class Basic <  Sinatra::Base

		before do
			@user = session[:user]
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
	use Routes::Auth
	use Routes::Basic


end
