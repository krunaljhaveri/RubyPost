require 'spec_helper'

describe User do
  fixtures :categories, :users, :posts, :comments, :votes
  describe '.vote_count' do
    it 'returns the correct total count for votes received on posts and comments' do
      vote_count = User.find(5).vote_count
      vote_count.should equal(2)

      vote_count = User.find(1).vote_count
      vote_count.should equal(0)
    end
  end
  describe '.post_vote_count' do
    it 'returns the correct count for votes received on posts' do
      vote_count = User.find(5).post_vote_count
      vote_count.should equal(2)

      vote_count = User.find(1).post_vote_count
      vote_count.should equal(0)
    end
  end
  describe '.comment_vote_count' do
    it 'returns the correct count for votes received on comments' do
      vote_count = User.find(6).comment_vote_count
      vote_count.should equal(2)

      vote_count = User.find(5).comment_vote_count
      vote_count.should equal(0)
    end
  end
end