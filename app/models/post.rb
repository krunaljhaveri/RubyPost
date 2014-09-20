class Post < ActiveRecord::Base

  # To define custom <=> method
  include Comparable

  # Associations
  belongs_to :category
  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_many :votes, :as => :voteable, :dependent => :destroy

  # Model attributes that can be set via mass-assignment
  attr_accessible :title, :content, :tags, :user, :category_id, :votes, :category

  # Validate the presence of fields
  validates :content, :title, :user, :category, :presence => true

  # Vote count for this post
  def vote_count
    self.votes.count
  end

  # Score for this post
  # score = (10 + 10 * total_votes + 10 * num_comments_on_post) / elapsed_time
  # elapsed_time = current time - maximum(most recent comment update time, most recent post update time)
  def score
    last_updated = self.updated_at
    num_votes_on_post = self.votes.count
    num_comments_on_post = self.comments.count
    num_of_votes_on_comments = 0
    unless self.comments.order('updated_at DESC').empty?
      last_updated = [last_updated, self.comments.order('updated_at DESC').first.updated_at].max
      num_of_votes_on_comments = Vote.where("voteable_type = 'Comment' AND voteable_id IN (?)", self.comments).count
    end
    total_votes = num_votes_on_post + num_of_votes_on_comments
    elapsed_time = Time.now - last_updated
    (10 + 10 * total_votes + 10 * num_comments_on_post) / elapsed_time
  end

  # Compare the posts based on the score
  def <=>(another_post)
    if self.score < another_post.score
      -1
    elsif self.score > another_post.score
      1
    else
      0
    end
  end

  # Search method for posts
  # Returns all posts if the type or query parameters are empty or invalid
  # Returns filtered posts if the type and query parameters are valid
  # type of search includes: all, content (title, content, comment), tags, user, category
  def self.search(type, query)
    require 'set'
    result = Set.new

    if (!type or !query or type !~ /(all|category|user|tags|content)/ or query.length == 0)
      return Post.all
    end

    if (type == 'user' or type == 'all')
      users = User.where('LOWER(email) LIKE LOWER(?)', "%#{query}%")
      if users
        result.merge(Post.find_all_by_user_id(users))
        result.merge(Post.find(Comment.where('user_id IN (?)', users).pluck(:post_id)))
      end

      if ('anonymous'.include? query.downcase)
        result.merge(Post.where(:user_id => nil))
        result.merge(Post.find(Comment.where('user_id IS NULL').pluck(:post_id)))
      end
    end

    if (type == 'category' or type == 'all')
      categories = Category.where('LOWER(name) LIKE LOWER(?)', "%#{query}%")
      if categories
        result.merge(Post.find_all_by_category_id(categories))
      end

      if ('anonymous'.include? query.downcase)
        result.merge(Post.where(:category_id => nil))
      end
    end

    if (type == 'content' or type == 'all')
      result.merge(Post.where('LOWER(title) LIKE LOWER(?) OR LOWER(content) LIKE LOWER(?)', "%#{query}%", "%#{query}%"))
      result.merge(Post.find(Comment.where('LOWER(content) LIKE LOWER(?)', "%#{query}%").pluck(:post_id)))
    end

    if (type == 'tags' or type == 'all')
      result.merge(Post.where('LOWER(tags) LIKE LOWER(?)', "%#{query}%"))
    end

    result.to_a()

  end

  # Return all tags used in all posts
  def self.tags
    require 'set'
    tags = Set.new

    all_tags = Post.pluck(:tags)
    all_tags.each do |list_of_tags|
      if (list_of_tags and list_of_tags.length>0)
        list_of_tags.split(',').each do |tag|
          if tag.length > 0
            tags.add(tag)
          end
        end
      end
    end
    tags.to_a()
  end

end
