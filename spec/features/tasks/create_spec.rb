require 'rails_helper'

describe 'As a User', type: :feature do
  specify 'I can create a Task' do
    FactoryBot.create(:user, email: 'email@test.com', password: '123123', password_confirmation: '123123')
    visit new_user_session_path

    fill_in 'Email', with: 'email@test.com'
    fill_in 'Password', with: '123123'
    click_button 'Log in'

    visit new_task_path

    fill_in 'Description', with: 'My awesome description'
    click_button 'Create task'

    expect(Task.count).to eq 1
    expect(current_path).to eq tasks_path
    expect(page).to have_content('My awesome description')
  end
end
