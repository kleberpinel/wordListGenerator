ENV["REDISTOGO_URL"] ||= "redis://redistogo:725ba233d7be72f5b745300e4a7723e3@filefish.redistogo.com:9918/"

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)

Dir["/home/redis/9918/app/workers/*.rb"].each { |file| require file }