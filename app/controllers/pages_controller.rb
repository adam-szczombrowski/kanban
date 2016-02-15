class PagesController < ApplicationController
  def index
    if current_user
      if current_user.team
        redirect_to team_path current_user.team
      end
    end
  end

  def about
  end

  def contact
  end
end
