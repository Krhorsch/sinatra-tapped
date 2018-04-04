class BeersController < ApplicationController

  get '/beers' do
    if logged_in?
      @user = current_user
      erb :"/beers/beers"
    else
      redirect to '/login'
    end
  end

  get '/beers/new' do
    if logged_in?
      erb :"/beers/create_beer"
    else
      redirect to '/login'
    end
  end

  post '/beers' do
    if !params["name"].empty? && !params["brewery"].empty?
      @beer = Beer.create(name: params["name"], brewery: params["brewery"])
      redirect to '/beers'
    else
      redirect to '/beers/new'
    end
  end

  delete '/beers/:id' do
    @beer = Beer.find_by(id: params[:id])
    redirect to "/beers"
  end

  get '/beers/:id/edit' do
    if logged_in?
      @beer = Beer.find_by(id: params[:id])
      erb :"/beers/edit_beer"
    else
      redirect to "/login"
    end
  end

  patch '/beers/:id' do
    @beer = Beer.find_by(id: params[:id])
    if !params["name"].empty? && !params["brewery"].empty?
      @beer.update(name: params["name"], brewery: params["brewery"])
      redirect to "/beers/#{@beer.id}"
    else
      redirect to "/tweets/#{@beer.id}/edit"
    end
  end

  get '/beers/:id' do
    if logged_in?
      @beers = Beer.find_by(id: params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect to '/login'
    end
  end
end
