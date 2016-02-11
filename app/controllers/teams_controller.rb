class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:success] = "#{@team.name} team create"
      redirect_to root_path
    else
      flash[:danger] = 'Team not created'
      render 'new'
    end
  end

  private

  def team_params
    params.require(:team).premit(:name)
  end
end
