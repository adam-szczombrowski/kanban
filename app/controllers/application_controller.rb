class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

    def current_team #is this the right place for this function ?
      if current_user
        return current_user.team
      end
    end
end
