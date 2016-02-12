class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_team, only: [:edit, :show, :update]

  def new
    @team = current_team
    @task = @team.tasks.build
  end

  def create
    @task = Task.new(task_params)
    @task.team_id = current_user.team.id
    if @task.save
      redirect_to team_path(current_team)
    else
      flash[:danger] = 'Task not saved'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update_attributes(task_params)
      flash[:success] = 'Task updated'
      redirect_to team_task_path(@task)
    else
      flash[:danger] = 'Error'
      redirect_to root_path
    end
  end

  def show
  end

  def index
    @tasks = Task.where(team_id: current_user.team.id)
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end

  def correct_team
    @task = Task.find(params[:id])
    unless @task.part_of?(current_user.team)
      flash[:danger] = 'This is not your teams task'
      redirect_to root_path
    end
  end
end
