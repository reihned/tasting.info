require 'active_record'
# require 'sinatra'

class Wine < ActiveRecord::Base
end

class Maker < ActiveRecord::Base
end

class Tag < ActiveRecord::Base
end

class Review < ActiveRecord::Base
end

class Subscriber < ActiveRecord::Base
end

#
# class Application < Sinatra::Base
#   use ActiveRecord::ConnectionAdapters::ConnectionManagement
# end
