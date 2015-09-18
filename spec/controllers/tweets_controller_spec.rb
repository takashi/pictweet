require 'rails_helper'

RSpec.describe TweetsController, type: :controller do

  context 'when user access without sign in' do
    context 'GET #index' do
      it 'renders index template' do
        get :index
        expect(response).to render_template :index
      end
    end

    context 'except #index' do
      it 'redirects to index path' do
        get :new
        expect(response).to redirect_to action: :index
      end
    end
  end

  context 'when user logged in' do
    let!(:user) { create(:user_with_tweets, tweets_count: 10) }
    before { sign_in user }

    describe 'GET #index' do
      before { get :index }

      it 'assigns @tweets with tweets limited by pagination' do
        expect(assigns(:tweets)).to match_array(Tweet.order(created_at: :desc).limit(5))
      end
    end

    describe 'GET #new' do
      before { get :new }
      it 'renders #new template' do
        expect(response).to render_template :new
      end
    end

    describe 'POST #create' do
      it 'creates a new tweet' do
        expect{
          post :create, attributes_for(:tweet)
        }.to change { Tweet.count }.by(1)
      end
    end

    describe 'DELETE #destroy' do
      context 'with current_user\'s tweet' do
        it 'deletes the tweet' do
          tweet = user.tweets.first
          expect{
            delete :destroy, id: tweet
          }.to change { Tweet.count }.by(-1)
        end
      end

      context 'with non current_user\'s tweet' do
        it 'can\'t delete the tweet' do
          tweet = create(:tweet)
          expect{
            delete :destroy, id: tweet.to_param
          }.to change { Tweet.count }.by(0)
        end
      end
    end

    describe 'GET #edit' do
      it 'assigns @tweet by id' do
        get :edit, id: user.tweets.first.id
        expect(assigns(:tweet)).to eq(user.tweets.first)
      end
    end

    describe 'GET #update' do
      context 'with current_user\'s tweet' do
        it 'updates the tweet' do
          tweet = user.tweets.first
          patch :update, id: tweet.to_param, text: 'hogehoge'
          expect(tweet.reload.text).to eq('hogehoge')
        end
      end

      context 'with non current_user\'s tweet' do
        it 'can\'t update the tweet' do
          tweet = create(:tweet)
          patch :update, id: tweet.to_param, text: 'hogehoge'
          expect(tweet.reload.text).not_to eq('hogehoge')
        end
      end
    end
  end
end
