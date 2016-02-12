class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  validates :name, presence: true
  validates :description, presence: true

  def part_of?(team)
    team.tasks.include?(self)
  end
end
