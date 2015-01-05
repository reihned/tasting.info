require 'active_record'
require 'sinatra'
require 'mustache'
require 'json'

require './lib/classes.rb'
require './lib/connection.rb'
require './lib/functions.rb'

get '/' do
  #featured wine
  #latest ten
end

# wines

get '/wines' do
  line_new_wine = "<div class='new'><a href='/wines/new'>Add New Wine</a></div>"
  template_feed_wine = File.read('./templates/feed_wines.html')
  all_wines_raw = Wine.all
  all_wines = { wines: all_wines_raw.as_json }
  render_feed_wine = Mustache.render( template_feed_wine, all_wines )
  content_all = line_new_wine + render_feed_wine
  render_full(content_all)
end

get '/wines/new' do
  template_form_wine = File.read('./templates/add_wine.html')
  path = '/wines/new'
  render_form_wine = Mustache.render( template_form_wine, {path: path} )
end

post '/wines/new' do
  description = params[:description]
  snippet = description[0..135] + "..."
  wine = Wine.create(
    name:         params[:name],
    maker:        params[:maker],
    year:         params[:year],
    img_url:      params[:img_url],
    description:  params[:description],
    snippet:      snippet,
  ) # create

  redirect "/wines/#{wine.w_id}", 303, "Success!"
end

get '/wines/edit/:w_id' do
end

post '/wines/edit/:w_id' do
end

get '/wines/:w_id' do
end

# reviews
post '/wines/review' do
end

# makers

get '/makers' do
end

get '/makers/new' do
end

post '/makers/new' do
end

get '/makers/edit/m_id:' do
end

post '/wines/edit/m_id:' do
end

get '/makers/:m_id' do
end

# tags

get '/tags' do
end

get '/tags/:t_id' do
end

get '/tags/new' do
end

post '/tags/new' do
end
