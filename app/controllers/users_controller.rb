class UsersController < ApplicationController

  def show
    @nickname = current_user.nickname
    @tweets = current_user.tweets.page(params[:page]).per(5).order('created_at DESC')
    @tweets_count = current_user.count_tweets #こちらの行を追加
  end

  private
  def show_params
    params.permit(:id)
  end
end
