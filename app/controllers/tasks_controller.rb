class TasksController < ApplicationController
  before_action :authenticate

  def index
    @tasks = current_user.tasks
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(description: params[:task][:description], user: current_user)

    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def authenticate
    redirect_to new_user_session_path if current_user.blank?
  end
end
