class CreateTask < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.text :description
      t.datetime :completed_at
      t.datetime :email_sent_at
      t.belongs_to :user
      t.timestamps
    end
  end
end
