require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #show' do
    let!(:user) { create(:user_with_tweets) }
    before do
      sign_in user
      get :show, id: user.to_param
    end

    it 'assigns @nickname with current_user\'s nickname' do
      expect(assigns(:nickname)).to eq(user.nickname)
    end

    it 'assigns @tweets with current_user\'s tweets ordered by created_at' do
      expect(assigns(:tweets)).to eq(user.tweets.order(created_at: :desc))
    end

    it 'assigns @tweets_count with current_user\'s all tweet length' do
      expect(assigns(:tweets_count)).to eq(user.tweets.count)
    end

    context 'when pagination params passed' do
      let!(:user) { create(:user_with_tweets, tweets_count: 8) }

      before do
        sign_in user
        get :show, id: user.to_param, page: 1
      end

      it 'assigns @tweets that are limited by pagination' do
        expect(assigns(:tweets).length).to eq(5)
      end
    end
  end
end
