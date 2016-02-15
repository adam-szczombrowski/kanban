class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:show, :edit, :update]

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
    @tasksc1 = Task.where(team_id: @team.id, category: 'C1')
    @tasksc2 = Task.where(team_id: @team.id, category: 'C2')
    @tasksc3 = Task.where(team_id: @team.id, category: 'C3')
    @tasksc3 = Task.where(team_id: @team.id, category: 'C4')
  end

  def edit
  end

  def update
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

  def correct_user
    @team = Team.find(params[:id])
    unless @team.has_user?(current_user)
      flash[:danger] = 'This is not your team'
      redirect_to root_path
    end
  end
end
