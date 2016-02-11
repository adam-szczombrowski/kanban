module TeamsHelper
  def owner?(team) #checs if current user belongs to team
    unless current_user.team == team
      flash[:danger] = 'This is not your team'
      redirect_to root_path
    end
  end
end
