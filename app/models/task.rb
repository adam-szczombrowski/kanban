class Task < ActiveRecord::Base
  belongs_to :user
  belongs_to :team

  validates :name, presence: true
  validates :description, presence: true

  def belongs?(team)
    unless self.team == team
      flash[:danger] = 'This is not your teams task'
      redirect_to root_path
    end
  end
end
