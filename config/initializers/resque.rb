ENV["REDISTOGO_URL"] ||= "redis://redistogo:b4edc514c65b15ad20b30f0dcae74631@filefish.redistogo.com:9938/"

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)

#Dir["/srv/redistogo/app/releases/20110926021225/app/jobs/*.rb"].each { |file| require file }
Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }