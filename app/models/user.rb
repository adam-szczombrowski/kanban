class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :team
  has_many :tasks

  def part_of?(team)
    unless self.team == team
      flash[:danger] = 'This is not your team'
      redirect_to root_path
    end
  end
end
