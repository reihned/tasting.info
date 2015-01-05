require 'active_record'
require 'sinatra'
require 'mustache'
require 'json'

require 'pry'

require './lib/classes.rb'
require './lib/connection.rb'
require './lib/functions.rb'

get '/' do
  #featured wine
  #latest ten
  wines_latest = Wine.limit(5).order("id DESC")
  template_feed_wine = File.read('./templates/feed_wines.html')
  content = Mustache.render(template_feed_wine, wines_latest)
  render_full(content)
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

  render_full(render_form_wine)
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

  maker = Maker.find_by(name: wine.maker)

  if maker == nil
    maker_new = Maker.create( name: wine.maker )
  end

  redirect "/wines/#{wine.w_id}", 303, "Success!"
end

get '/wines/edit/:w_id' do
end

post '/wines/edit/:w_id' do
end

get '/wines/:w_id' do
  w_id = params[:w_id]
  wine_info = Wine.find_by(w_id: w_id)
  maker_info = Maker.find_by(name: wine_info.maker)
  tag_arr = wine_info.tags.split(" ")

  info = wine_info.as_json
  info[:maker_url] = maker_info.website_url
  info[:tag_arr] = tag_arr

  template_info = File.read('./templates/info_wine.html')
  content = Mustache.render( template_info, info )
  render_full(content)
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

get '/tags/:tag' do
end
