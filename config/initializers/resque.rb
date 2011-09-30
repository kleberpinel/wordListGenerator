ENV["REDISTOGO_URL"] ||= "redis://redistogo:59455c85bb6b5f9cd5d52bed2e2d1fc2@bass.redistogo.com:9095/"

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)

#Dir["/srv/redistogo/app/releases/20110926021225/app/jobs/*.rb"].each { |file| require file }
Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }