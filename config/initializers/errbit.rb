Airbrake.configure do |config|
  config.api_key = '***REMOVED***'
  config.host    = '***REMOVED***'
  config.port    = 80
  config.secure  = config.port == 443
end