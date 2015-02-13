require 'active_record'
require 'sendgrid-ruby'
require 'json'

ActiveRecord::Base.establish_connection('postgresql://' + ENV["DB_INFO"] + '@127.0.0.1/tastings')
sg_info = JSON.parse(ENV["SG_INFO"])
sg_user = sg_info["api_user"]
sg_key = sg_info["api_key"]
sg_client = SendGrid::Client.new(api_user: sg_user, api_key: sg_key)
