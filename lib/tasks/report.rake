require 'csv'

namespace :report do
  desc "generate report of events"
  task events: :environment do
    events = Event.where(event_type: 'task_completed').all
    tasks_map = {}
    tasks = Task.find(events.map { |event| event.data['task_id'] })
    tasks.each do |task|
      tasks_map[task.id] = task
    end

    CSV.open("events_report_#{Time.current.to_i}.csv", "wb") do |csv|
      csv << ['event_id', 'task_id', 'completed_at', 'message', 'message_color']

      events.each do |event|
        task = tasks_map[event.data['task_id']]
        csv << [
          event.id,
          task.id,
          task.completed_at.iso8601,
          event.data['message'],
          event.data['message_color']
        ]
      end
    end
  end

end
