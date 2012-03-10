class TweetsController < ApplicationController
  
  def index
    @tweets = Tweet.all
  end
  
  def new
    @tweet = Tweet.new
  end
  
  def create
    @tweet = Tweet.new(params[:tweet])

    if @tweet.save
      redirect_to tweets_path
    else
      render "new"
    end
  end
  
  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy    
    redirect_to tweets_path   
  end
  
end