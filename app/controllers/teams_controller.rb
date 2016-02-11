class TeamsController < ApplicationController
  include TeamsHelper
  before_action :authenticate_user!

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    current_user.team = @team
    owner?(@team)
    if @team.save
      flash[:success] = "#{@team.name} team create"
      redirect_to @team
    else
      flash[:danger] = 'Team not created'
      render 'new'
    end
  end

  def show
    @team = Team.find(params[:id])
    owner?(@team)
  end

  def edit
    @team = Team.find(params[:id])
    owner?(@team)
  end

  def update
    @team = Team.find(params[:id])
    owner?(@team)
    if @team.update_attributes(team_params)
      flash[:success] = "Team #{@team.name} edited"
      redirect_to @team
    else
      flash[:danger] = 'Team not edited'
      render 'edit'
    end
  end

  private

  def team_params
    params.require(:team).permit(:name)
  end
end
