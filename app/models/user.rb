class User < ActiveRecord::Base

  # Devise configuration
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations
  has_many :posts, :dependent => :nullify
  has_many :votes
  has_many :comments, :dependent => :nullify

  # Model attributes that can be set via mass-assignment
  attr_accessible :email, :password, :password_confirmation,
                  :remember_me, :admin, :super_admin

  # Validate the presence of fields
  validates :email, presence: true, uniqueness: true

  # Count of all votes received by the user in the given time period
  def vote_count(from_time = DateTime.current.beginning_of_year, to_time = DateTime.current)
    self.post_vote_count(from_time, to_time) + self.comment_vote_count(from_time, to_time)
  end

  # Count of votes received by the user on posts in the given time period
  def post_vote_count(from_time = DateTime.current.beginning_of_year, to_time = DateTime.current)
    Vote.where("voteable_type = 'Post' AND voteable_id IN (?) AND created_at >= ? AND created_at <= ?", self.posts, from_time, to_time).count
  end

  # Count of votes received by the user on comments in the given time period
  def comment_vote_count(from_time = DateTime.current.beginning_of_year, to_time = DateTime.current)
    Vote.where("voteable_type = 'Comment' AND voteable_id IN (?) AND created_at >= ? AND created_at <= ?", self.comments, from_time, to_time).count
  end

  # Count of posts created by the user
  def post_count(from_time = DateTime.current.beginning_of_year, to_time = DateTime.current)
    self.posts.where('created_at >= ? AND created_at <= ?', from_time, to_time).count
  end

  # Count of comments created by the user
  def comment_count(from_time = DateTime.current.beginning_of_year, to_time = DateTime.current)
    self.comments.where('created_at >= ? AND created_at <= ?', from_time, to_time).count
  end
end
