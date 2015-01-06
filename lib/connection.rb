require 'active_record'
require 'sendgrid-ruby'

ActiveRecord::Base.establish_connection('postgresql://' + ENV["DB_INFO"] + '@127.0.0.1/tastings')

sg_client = SendGrid::Client.new(ENV["SG_INFO"])
