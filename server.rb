require 'active_record'
require 'sinatra'
require 'mustache'

require './lib/classes.rb'
require './lib/connection.rb'
require './lib/functions.rb'

get '/' do
end

# wines

get '/wines' do
end

get '/wines/new' do
end

get '/wines/edit/:w_id' do
end

get '/wines/:w_id' do
end

# makers

get '/makers' do
end

get '/makers/new' do
end

get '/makers/edit/m_id:' do
end

get '/makers/:m_id' do
end
