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

  delete '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if current_user.id == @tweet.user_id
      @tweet.delete
    end
    redirect to "/tweets"
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by(id: params[:id])
    if !params["content"].empty?
      @tweet.update(content: params["content"])
      redirect to "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end


  get '/tweets/:id/edit' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :"/tweets/edit_tweet"
    else
      redirect to "/login"
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find_by(id: params[:id])
      erb :"/tweets/show_tweet"
    else
      redirect to '/login'
    end
  end
end
