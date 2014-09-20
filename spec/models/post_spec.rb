require 'spec_helper'

describe Post do

  # Load all the fixtures required for the tests!
  fixtures :categories, :users, :posts, :comments, :votes

  describe '.sort' do
    it 'sorts the posts based on the score i.e. in the order Post 1, Post 3, Post 2' do
      posts = Post.first(3).sort.reverse
      [posts[0].id, posts[1].id, posts[2].id].should match_array([1, 3, 2])
    end
  end

  describe '.search' do
    it 'returns the right result when we search for a category that exists' do
      posts = Post.search('category', 'homework')
      posts.map do
      |post|
        post.id
      end.should match_array([1])
    end
    it 'returns the right result when we search for a category that does not exist' do
      posts = Post.search('category', 'foobar')
      posts.map do
      |post|
        post.id
      end.should match_array([])
    end
    it 'returns the right result when we search for a content that exists' do
      posts = Post.search('content', 'railscast')
      posts.map do
      |post|
        post.id
      end.should match_array([2])
    end
    it 'returns the right result when we search for a content that does not exist' do
      posts = Post.search('content', 'foobar')
      posts.map do
      |post|
        post.id
      end.should match_array([])
    end
    it 'returns the right result when we search by users who have some posts' do
      posts = Post.search('user', 'user')
      posts.map do
      |post|
        post.id
      end.should match_array([1, 2, 3])
    end
    it 'returns the right result when we search by user who do not have any posts' do
      posts = Post.search('user', 'foobar')
      posts.map do
      |post|
        post.id
      end.should match_array([])
    end
    it 'returns the right result when we search for a tag that has some posts' do
      posts = Post.search('tags', 'quiz')
      posts.map do
      |post|
        post.id
      end.should match_array([3])
    end
    it 'returns the right result when we search for a tag that does not have any posts' do
      posts = Post.search('tags', 'foobar')
      posts.map do
      |post|
        post.id
      end.should match_array([])
    end
    it 'returns the right result when we search in all fields' do
      posts = Post.search('all', 'score')
      posts.map do
      |post|
        post.id
      end.should match_array([3])
    end
    it 'returns the right result when we search in all fields for a query for which a post does not exist' do
      posts = Post.search('all', 'foobar')
      posts.map do
      |post|
        post.id
      end.should match_array([])
    end
  end

  describe '.vote_count' do
    it 'returns the correct vote count' do
      vote_count = Post.find(1).vote_count
      vote_count.should equal(2)

      vote_count = Post.find(3).vote_count
      vote_count.should equal(0)

    end
  end

  describe '.tags' do
    it 'returns all the tags that exist' do
      tags = Post.tags
      tags.sort.should match_array(["deadline", "homework1", "project1", "quiz2", "scores", "tutorial", "webassign", "webrat"])
    end
  end
end