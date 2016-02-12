class TasksController < ApplicationController
  before_action :authenticate_user!

  def new
    @team = current_team
    @task = @team.tasks.build
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    @task.team_id = params[:team_id]
    belongs?(@task, current_team)
    if @task.save
      redirect_to root_path
    else
      flash[:danger] = 'Task not saved'
      render 'new'
    end
  end

  def edit
    @team = current_team
    @task = Task.find(params[:id])
    belongs?(@task, current_team)
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      flash[:success] = 'Task updated'
      redirect_to @task
    else
      flash[:danger] = 'Error'
      redirect_to root_path
    end
  end

  def show
    @task = Task.find(params[:id])
    belongs?(@task, current_team)
  end

  def index
    @tasks = Task.where(team_id: current_team.id)
  end

  private

    def task_params
      params.require(:task).permit(:name, :description)
    end

    def belongs?(task, team) #where this function should be ?
      unless task.team == team
        flash[:danger] = 'This is not your teams task'
        redirect_to root_path
      end
    end
end
