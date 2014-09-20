class Category < ActiveRecord::Base

  # Associations
  has_many :posts, :dependent => :nullify

  # Model attributes that can be set via mass-assignment
  attr_accessible :name

  # Validate the presence of fields
  validates :name, presence: true

end
