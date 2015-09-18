require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has valid factory' do
    expect(build(:user)).to be_valid
  end

  describe 'validation' do
    it 'is invalid without nickname' do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include('can\'t be blank')
    end

    it 'is invalid with duplicated nickname' do
      create(:user, nickname: 'john')
      user = build(:user, nickname: 'john')
      user.valid?
      expect(user.errors[:nickname]).to include('has already been taken')
    end
  end

  describe '#count_tweets' do
    let(:count) { 5 }
    let(:user) { create(:user_with_tweets, tweets_count: count) }

    it 'returns tweet count that the user instance has' do
      expect(user.count_tweets).to eq(count)
    end
  end
end
