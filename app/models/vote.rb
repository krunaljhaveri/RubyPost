class Vote < ActiveRecord::Base

  # Associations
  belongs_to :user
  belongs_to :voteable, :polymorphic => true

  # Model attributes that can be set via mass-assignment
  attr_accessible :user, :voteable_id, :voteable_type

end