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
					session[:user] = user.id
				else
					session[:flash] = "Login details are fake."
					redirect to('/signin', 'habu')
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

			session[:user] = User.first(:username => "anonymous").id unless session[:user]
			@user = User.first(:id => session[:user])

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
			@user = User.first(:id => session[:user])
		end

		get '/' do

			haml :home

		end

		get '/popular_urls' do 

			@popular_urls = Url.by_popularity
			haml :popular_urls
		end

		get '/my_urls' do

			@my_urls = @user.urls
			haml :my_urls

		end

		get '/failure' do 

			@message = params[:message]
			haml :failure
		end

		['/:custom_prefix/:short_hash', '/:short_hash'].each  do |route|
			get route do
			
				sh = params[:short_hash]
				id = Base62.rconvert62(sh)
				@absolute_url = Url.first(:id)
				if @absolute_url
					@absolute_url.update(:popularity => (@absolute_url.popularity + 1))
					redirect to(@absolute_url.absolute)
				end

				redirect to("/failure")
			end

		end


		post '/shorten' do

			Url.raise_on_save_failure = true
			@url = @user.urls.new
			@url.absolute = params[:url]
			@url.short_hash = @url.compute_hash
			@short_version = @url.shortened_url
			@url.save
			haml :result
		end

		delete '/delete/:url_id' do 
			@url = Url.get(params[:url_id])
			@url.destroy

			redirect to('/my_urls')
		end
	end

end

class JetFuel < Sinatra::Base

	use Configuration
	use Routes::Auth
	use Routes::Basic


end
