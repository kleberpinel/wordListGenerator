#Replace HERE for your URL in RedisToGo
ENV["REDISTOGO_URL"] ||= "redis://redistogo:bc5f5b89a23c73aa7cc15fc358f6c105@pike.redistogo.com:9302/"

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)

#Dir["/srv/redistogo/app/releases/20110926021225/app/jobs/*.rb"].each { |file| require file }
Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }