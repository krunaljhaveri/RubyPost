class Comment < ActiveRecord::Base

  # Associations
  belongs_to :post
  belongs_to :user
  has_many :votes, :as => :voteable, :dependent => :destroy

  # Model attributes that can be set via mass-assignment
  attr_accessible :content, :post, :user, :votes, :post_id

  # Validate the presence of fields
  validates :content, :user, :post, :presence => true

  # Vote count for this comment
  def vote_count
    self.votes.count
  end

end
