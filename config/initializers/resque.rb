ENV["REDISTOGO_URL"] ||= "redis://redistogo:870b7b8f326dcde354d66058733921f9@pike.redistogo.com:9302/"

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)

#Dir["/srv/redistogo/app/releases/20110926021225/app/jobs/*.rb"].each { |file| require file }
Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }