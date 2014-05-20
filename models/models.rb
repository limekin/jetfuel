DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, "postgres://postgres:rubyist12@localhost/Jetfuel")


class User

	include DataMapper::Resource

	property :id, Serial
	property :username, String
	has n, :urls

end

class Url 

	include DataMapper::Resource

	property :id, Serial
	property :absolute, String
	property :short_hash, String
	property :popularity, Integer

	belongs_to :user

end


DataMapper.auto_migrate!

User.create(username: "anonymous")
