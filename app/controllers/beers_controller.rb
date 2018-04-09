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
      @beer_names = Beer.all.collect{|beer| beer.name}.uniq
      @user_beer_names = current_user.beers.collect{|beer| beer.name}
      @beers = []
      @beer_names.each do |x|
        if !@user_beer_names.include?(x)
          @beers << x
        end
      end
      erb :"/beers/create_beer"
    else
      redirect to '/login'
    end
  end

  post '/beers' do
    if !params["name"].empty? && !params["brewery"].empty?
      @beer = Beer.create(name: params["name"], brewery: params["brewery"])
      current_user.beers << @beer
    end
    if params["beers"]
      params["beers"].each do |beer|
        new_beer = Beer.find_by(name: beer)
        Beer.create(name: "#{beer}", brewery: "#{new_beer.brewery}", user_id: "#{current_user.id}")
      end
    end
      redirect to "/users/:id"
  end

  delete '/beers/:id' do
    @beer = Beer.find_by(id: params[:id])
    if @beer.user_id == current_user.id
      @beer.delete
      redirect to "/users/:id"
    else
      redirect to "/users/:id"
    end
  end

  get '/beers/:id/edit' do
    @beer = Beer.find_by(id: params[:id])
    if logged_in? && @beer.user_id == current_user.id
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
