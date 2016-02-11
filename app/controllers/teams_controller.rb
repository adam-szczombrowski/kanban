class TeamsController < ApplicationController
  before_action :authenticate_user!

  def new
    if current_user.team
      flash[:danger] = 'You already belong to a team'
      redirect_to root_path
    else
      @team = Team.new
    end
  end

  def create
    @team = Team.new(team_params)
    @team.users << current_user
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
    current_user.part_of?(@team)
  end

  def edit
    @team = Team.find(params[:id])
    current_user.part_of?(@team)
  end

  def update
    @team = Team.find(params[:id])
    current_user.part_of?(@team)
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
