module ApplicationHelper
  def current_team
    return current_user.team if current_user
  end
end
