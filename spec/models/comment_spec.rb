require 'spec_helper'

describe '.vote_count' do

  # Load all the fixtures required for the tests!
  fixtures :categories, :users, :posts, :comments, :votes

  it 'returns the correct vote count' do
    vote_count = Comment.find(1).vote_count
    vote_count.should equal(1)

    vote_count = Comment.find(2).vote_count
    vote_count.should equal(1)
  end

end
