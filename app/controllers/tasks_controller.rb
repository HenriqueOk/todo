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

    email_random_params = Task::CompletedEmailParams.call

    @task.transaction do
      @task.save!
      Event.create!(
        event_type: 'task_completed',
        data: {
          task_id: @task.id,
          message: email_random_params.message,
          message_color: email_random_params.message_color
        }
      )
      TaskMailer.with(
        task_id: @task.id,
        message: email_random_params.message,
        message_color: email_random_params.message_color
      ).completed.deliver_later
    end

    redirect_to tasks_path
  end

  private

  def authenticate
    redirect_to new_user_session_path if current_user.blank?
  end
end
