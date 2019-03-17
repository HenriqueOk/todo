require 'rails_helper'

describe 'As a User', type: :feature do
  specify 'I can create a Task' do
    user = FactoryBot.create(:user, email: 'email@test.com', password: '123123', password_confirmation: '123123')
    visit new_user_session_path

    fill_in 'Email', with: 'email@test.com'
    fill_in 'Password', with: '123123'
    click_button 'Log in'

    task = FactoryBot.create(:task, description: 'Task description', user: user)

    visit tasks_path

    page.find(".cpy-edit-task-#{task.id}").click

    fill_in 'Description', with: 'My NEW description'
    click_button 'Update task'

    expect(current_path).to eq tasks_path
    expect(page).to have_content('My NEW description')
  end
end
