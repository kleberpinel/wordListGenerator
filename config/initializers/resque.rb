ENV["REDISTOGO_URL"] ||= "redis://redistogo:182d3a3a09cad1306ec76d760ea2d6e7@goosefish.redistogo.com:9971/"

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password, :thread_safe => true)

#Dir["/srv/redistogo/app/releases/20110926021225/app/jobs/*.rb"].each { |file| require file }
Dir["/home/redis/9934/app/jobs/*.rb"].each { |file| require file }