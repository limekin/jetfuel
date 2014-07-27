
## Development
# DataMapper.setup(:default, "postgres://postgres:rubyist12@localhost/Jetfuel")
DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, ENV["DATABASE_URL"])



class User

	include DataMapper::Resource

	property :id, Serial
	property :username, String, :required => true
	property :password, String
	has n, :urls


end

class Url 

	include DataMapper::Resource

	property :id, Serial
	property :absolute, Text 
	property :short_hash, Text
	property :custom_prefix, Text
	property :popularity, Integer, :default => 0

	belongs_to :user

	def compute_hash

		id = DataMapper.repository(:default).adapter.select("SELECT nextval('id_gen')")[0]
		Base62.convert62(id)

	end

	def shortened_url

		ret = "http://localhost:9292/" 
		ret += self.custom_prefix + "/" if custom_prefix
		ret += self.short_hash

	end

	def self.by_popularity

		all(:user_id => 1, :order => [:popularity.desc])

	end

	def self.to_absolute(short_hash, custom_prefix)

		url = first(:short_hash => short_hash, :custom_prefix => custom_prefix)
		return url.absolute if url
		nil
	end

end


DataMapper.auto_upgrade!

User.create(username: "anonymous") unless User.first(:username => "anonymous")

adapter = DataMapper.repository(:default).adapter

if adapter.select("SELECT EXISTS ( SELECT * FROM id_gen)")[0] == 't'
	adapter.execute "CREATE SEQUENCE id_gen MINVALUE 0"
end
