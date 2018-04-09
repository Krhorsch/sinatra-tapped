class BeersController < ApplicationController

  get '/beers' do
    if logged_in?
      @user = current_user
      @beers = Beer.all
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
    if params["name"] && params["brewery"]
      @beer = Beer.create(name: params["name"], brewery: params["brewery"])
      current_user.beers << @beer
      if params["beers"]
        params["beers"].each do |beer|
          new_beer = Beer.find_by(name: beer)
          current_user.beers << new_beer
        end
      end
    end
      redirect to "/users/:id"
  end

  delete '/beers/:id' do
    @beer = Beer.find_by(id: params[:id])
    @beer.delete
    redirect to "/users/:id"
  end

  get '/beers/:id/edit' do
    if logged_in?
      @beer = Beer.find_by(id: params[:id])
      if @beer.user_id == current_user.id
        erb :"/beers/edit_beer"
      end
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
      redirect to "/beers/#{@beer.id}/edit"
    end
  end

  get '/beers/:id' do
    if logged_in?
      @beer = Beer.find_by(id: params[:id])
      erb :"/beers/show_beer"
    else
      redirect to '/login'
    end
  end
end
