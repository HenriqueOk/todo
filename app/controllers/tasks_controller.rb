class TasksController < ApplicationController
  before_action :authenticate

  def index
    @tasks = current_user.tasks
  end

  def new
    @task = Task.new
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    @task.description = params[:task][:description]

    if @task.save
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def create
    @task = Task.new(description: params[:task][:description], user: current_user)

    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def destroy
    @task = Task.find(params[:id])

    @task.destroy

    redirect_to tasks_path
  end

  def complete
    @task = Task.find(params[:id])
    @task.completed_at = Time.current

    @task.save

    redirect_to tasks_path
  end

  private

  def authenticate
    redirect_to new_user_session_path if current_user.blank?
  end
end
