class Team < ActiveRecord::Base
  has_many :users
  has_many :tasks, dependent: :destroy
  validates :name, presence: true

  def has_user?(user)
    user.team == self
  end
end
