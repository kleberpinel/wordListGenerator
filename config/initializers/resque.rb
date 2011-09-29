ENV["REDISTOGO_URL"] ||= "redis://kleberpinel:soumaisdeus@wordlistgenerator.heroku.com:6789"

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

Dir["#{Rails.root}/app/workers/*.rb"].each { |file| require file }