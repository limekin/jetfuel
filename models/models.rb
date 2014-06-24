DataMapper::Logger.new($stdout, :debug)
DataMapper.setup(:default, "postgres://postgres:rubyist12@localhost/Jetfuel")


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
	property :absolute, String, :required => true
	property :short_hash, String, :required => true
	property :custom_prefix, String, :default => ""
	property :popularity, Integer, :default => 0

	belongs_to :user
	before :valid?, :compute_hash

	def compute_hash(context = :default)

		self.short_hash = OPEN::SSL::Digest::SHA224.new.digest(self.absolute)

	end

	def shortened_url

		"/" + self.custom_prefix + "/" + self.short_hash

	end

	def self.by_popularity

		all(:order => [:popularity.desc])

	end

	def self.to_absolute(short_hash, custom_prefix)

		url = first(:short_hash => short_hash, :custom_prefix => custom_prefix)
		return url.absolute if url
		nil
	end

end


DataMapper.auto_upgrade!

User.create(username: "anonymous") unless User.first(:username => "anonymous")
