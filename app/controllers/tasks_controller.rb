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
  end

  def update
  end

  def show
  end

  def index
  end

  private

    def task_params
      params.require(:task).permit(:name, :description)
    end
end
