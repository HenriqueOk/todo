class TaskMailer < ApplicationMailer
  def completed
    task = Task.find(params[:task_id])
    @message = params[:message]
    @message_color = params[:message_color]
    mail(to: @task.user.email, subject: "Congratulations! You completed \"#{task.description}\"")
  end
end
