require 'rails_helper'

RSpec.feature "User Features", type: :feature do
  #pending "add some scenarios (or delete) #{__FILE__}"

  context 'create new user' do

    before(:each) do
      visit new_user_path
      within('form') do # within('#form-id') do or within('.form-class') do
        fill_in 'First name', with: 'john'
        fill_in 'Last name', with: 'doe'
        fill_in 'Username', with: 'john'
      end
    end

    scenario "should be successfull" do
      #visit new_user_path
      # within('form') do # within('#form-id') do or within('.form-class') do
      #   fill_in 'First name', with: 'john'
      #   fill_in 'Last name', with: 'doe'
      #   fill_in 'Email', with: 'john.doe@example.com'
      # end
      within('form') do
        fill_in 'Email', with: 'john.doe@example.com'
      end
      click_button 'Create User'
      expect(page).to have_content('User was successfully created.')

    end

    scenario "should fail" do
      #visit new_user_path
      # within('form') do # within('#form-id') do or within('.form-class') do
      #   fill_in 'First name', with: 'john'
      #   fill_in 'Last name', with: 'doe'
      # end
      click_button 'Create User'
      expect(page).to have_content("Email can't be blank")
    end

  end

  # context 'update user' do
  #   scenario 'should be successfull' do
  #     user = User.create(first_name: 'John', last_name: 'Doe', email: 'john.doe@example.com')
  #     visit edit_user_path(user)
  #
  #     within('form') do
  #       fill_in 'First name', with: 'Jane'
  #       fill_in 'Email', with: 'jane.doe@example.com'
  #     end
  #
  #     click_button 'Update User'
  #
  #     expect(page).to have_content('User was successfully updated.')
  #     expect(page).to have_content('jane.doe@example.com')
  #   end
  #
  #   scenario "should fail" do
  #     user = User.create(first_name: 'John', last_name: 'Doe', email: 'john.doe@example.com')
  #     visit edit_user_path(user)
  #
  #     within('form') do
  #       fill_in 'First name', with: ''
  #     end
  #
  #     click_button 'Update User'
  #     expect(page).to have_content('First name can\'t be blank')
  #   end
  #
  # end

  # With Refactored
  context 'update user' do
    let!(:user) {User.create(first_name: 'John', last_name: 'Doe', username: 'john', email: 'john.doe@example.com')}
    before(:each) do
      visit edit_user_path(user)
    end
    scenario 'should be successfull' do
      within('form') do
        fill_in 'First name', with: 'Jane'
        fill_in 'Email', with: 'jane.doe@example.com'
      end

      click_button 'Update User'

      expect(page).to have_content('User was successfully updated.')
      expect(page).to have_content('jane.doe@example.com')
    end

    scenario "should fail" do
      within('form') do
        fill_in 'First name', with: ''
      end

      click_button 'Update User'
      expect(page).to have_content('First name can\'t be blank')
    end

  end

  context 'destroy user' do
    scenario 'should be successfull' do
      user = User.create(first_name: 'John', last_name: 'Doe', username: 'john', email: 'john.doe@example.com')
      visit users_path

      #click_link 'Destroy'
      accept_confirm do
        click_link 'Destroy'
      end
      expect(page).to have_content('User was successfully destroyed.')
    end

  end
end
