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
  wines_latest_raw = Wine.limit(5).order("w_id DESC")
  wines_latest = {wines: wines_latest_raw.as_json}

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
    tags:         params[:tags],
    snippet:      snippet
  ) # create

  #If maker does not already exist, make a new maker

  maker = Maker.find_by(name: wine.maker)

  if maker == nil
    maker_new = Maker.create( name: wine.maker )
  end

  #if tags dont already exist, make new tags

  tag_arr = wine.tags.split(" ")

  tag_arr.each do |tag|
    if Tag.find_by(tag: tag) == nil
      new_tag = Tag.create( tag: tag )
    end
  end

  redirect "/wines/#{wine.w_id}", 303, "Success!"
end

get '/wines/edit/:w_id' do
  w_id = params[:w_id]
  wine = Wine.find_by(w_id: w_id)
  path = "/wines/edit/#{w_id}"

  wine_info = wine.as_json

  wine_info["path"] = path

  template_edit = File.read("./templates/edit_wine.html")
  rendered_form = Mustache.render(template_edit, wine_info)

  render_full(rendered_form)

end

post '/wines/edit/:w_id' do
  w_id = params[:w_id]
  wine = Wine.find_by(w_id: w_id)

  description = params[:description]
  snippet = description[0..135] + "..."

  wine.update(
    name:         params[:name],
    maker:        params[:maker],
    year:         params[:year],
    img_url:      params[:img_url],
    description:  params[:description],
    tags:         params[:tags],
    snippet:      snippet
  ) # update

  wine.save

  #If maker does not already exist, make a new maker

  maker = Maker.find_by(name: wine.maker)

  if maker == nil
    maker_new = Maker.create( name: wine.maker )
  end

  #if tags dont already exist, make new tags

  tag_arr = wine.tags.split(" ")

  tag_arr.each do |tag|
    if Tag.find_by(tag: tag) == nil
      new_tag = Tag.create( tag: tag )
    end
  end

  redirect "/wines/#{wine.w_id}", 303, "Success!"

end

get '/wines/:w_id' do
  w_id = params[:w_id]
  wine_info = Wine.find_by(w_id: w_id)
  maker_info = Maker.find_by(name: wine_info.maker)
  tag_arr = wine_info.tags.split(" ")

  info = wine_info.as_json
  # info[:maker_url] = maker_info.website_url
  info[:maker_url] = "/makers/#{maker_info.m_id}"
  info[:tag_arr] = tag_arr

  template_info = File.read('./templates/info_wine.html')
  content = Mustache.render( template_info, info )

  #edit link

  edit_link = "<div class='edit_button' ><a href='/wines/edit/#{w_id}'>EDIT<a><div> "
  content += edit_link

  #review feed
  template_reviews = File.read('./templates/feed_reviews.html')
  reviews_raw = Review.find_by(w_id: w_id)
  reviews = {reviews: reviews_raw.as_json}
  reviews_html = Mustache.render(template_reviews, reviews)

  content += reviews_html

  #review form add new
  template_review_new = File.read('./templates/add_review.html')
  review_form = Mustache.render(template_review_new, {w_id: w_id})

  content += review_form

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
