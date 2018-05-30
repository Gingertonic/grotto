require 'spec_helper'

describe UsersController do
  before do
    beti = User.create({first_name: "Beth", last_name: "Schofield", username: "Gingertonic", email: "thegingertonicstudios@gmail.com", password: "password"})
    aki = User.create({first_name: "Aleksandar", last_name: "Gakovic", username: "aleksea_g", email: "al@bear.com", password: "testing"})
    dive1 = Dive.create(date: "17/04/2018")
    dive2 = Dive.create(date: "01/30/2017")
    grotto = Divesite.create(name: "Ariels Grotto", location: "Menjangan Island, Bali", country: "Indonesia")
    epcot = Divesite.create(name: "Living Seas at Epcot", location: "Disneyworld", country: "USA")
    dive1.user = aki
    dive1.divesite = grotto
    dive1.save
    dive1.user = aki
  end

  after do
    User.destroy_all
    Dive.destroy_all
    Divesite.destroy_all
  end

  describe 'sign up page' do
    it 'loads the sign up page' do
      get '/signup'
      expect(last_response.body).to include("Welcome to the")
    end

    it 'directs new users to a page where they can add a profile image' do
      params = {first_name: "New", last_name: "User", username: "newuser", email: "new@user.com", password: "password"}
      post '/create', params
      expect(last_response.location).to include("/set-profile-picture")
    end

    it 'does not let a user sign up without a password' do
      params = {first_name: "Beth", last_name: "Schofield", username: "Gingertonic", email: "thegingertonicstudios@gmail.com"}
      post '/create', params
      expect(last_response.location).to include("/signup")
    end

    it 'does not let a logged in user see the signup page' do
      params = {first_name: "Another", last_name: "User", username: "anotheruser", email: "anotheruser@gmail.com", password: "password"}
      post '/create', params
      get '/signup'
      expect(last_response.location).to include("/dives")
    end
  end


  describe 'user homepage' do
    it 'shows only 1 users dives' do
      params = {username: "aleksea_g", password: "testing"}
      post '/login', params
      get '/divelogs/aleksea_g'
      expect(last_response.body).to include("Ariels Grotto")
      expect(last_response.body).to_not include("Living Seas at Epcot")
    end
  end

  describe 'edit user page'do
    before(:each) do
      get '/logout'
      params = {username: "aleksea_g", password: "testing"}
      post '/login', params
      get '/users/aleksea_g/edit'
    end

    it 'loads a page to edit user account details' do
      expect(last_response.body).to include('Update your account details')
    end

    it 'allows user to update their details' do
      params = {username: "aleksea_g", first_name: "Aleksandar", last_name: "Schofield", email: "al@bear.com", image_url: "", new_password: "", password_confirmation: "", password: "testing"}
      patch '/users/aleksea_g', params
      expect(User.find_by_username("aleksea_g").last_name).to eq("Schofield")
    end

    it 'does not allow user to have an empty email' do
      params = {username: "aleksea_g", first_name: "Aleksandar", last_name: "Gakovic", email: "", image_url: "", new_password: "", password_confirmation: "", password: "testing"}
      patch '/users/aleksea_g', params
      follow_redirect!
      expect(last_response.body).to include('Please confirm your current password')
    end

    it 'does not allow a user to edit another users details' do
      get '/logout'
      params = {username: "Gingertonic", password: "password"}
      post '/login', params
      get '/divelogs/aleksea_g/edit'
      params = {username: "aleksea_g", first_name: "Bobby", last_name: "Gakovic", email: "al@bear.com", image_url: "", new_password: "", password_confirmation: "", password: "testing"}
      patch '/users/aleksea_g', params
      follow_redirect!
      expect(last_response.body).to include("Aleksea G's Log")
    end

    it 'redirects to current users divelog if successful edit' do
      params = {username: "aleksea_g", first_name: "Alek", last_name: "Gakovic", email: "al@bear.com", image_url: "", new_password: "", password_confirmation: "", password: "testing"}
      patch '/users/aleksea_g', params
      follow_redirect!
      expect(User.find_by_username("aleksea_g").first_name).to eq("Alek")
      expect(last_response.body).to include("Aleksea G's Log")
    end

    it 'does not allow any changes with invalid password' do
      params = {username: "aleksea_g", first_name: "Aleksandar", last_name: "Gakovic", email: "aki@do.com", image_url: "", new_password: "", password_confirmation: "", password: "wrongpassword"}
      patch '/users/aleksea_g', params
      follow_redirect!
      expect(last_response.body).to include('Please confirm your current password')
      expect(User.find_by_username("aleksea_g").email).to eq("al@bear.com")
    end

    it 'verifies new password and does not allow change if passwords do not match' do
      params = {username: "aleksea_g", first_name: "Aleksandar", last_name: "Gakovic", email: "al@bear.com", image_url: "", new_password: "newpassword", password_confirmation: "notthenewpassword", password: "testing"}
      patch '/users/aleksea_g', params
      follow_redirect!
      expect(last_response.body).to include('Please confirm your current password')
    end

    it '(2nd test) verifies new password and does not allow change if passwords do not match' do
      visit '/login'
      fill_in 'username', with: 'aleksea_g'
      fill_in 'password', with: 'testing'
      click_button 'Login'

      visit '/users/aleksea_g/edit'

      fill_in 'new_password', with: "new"
      fill_in 'password_confirmation', with: "notnew"
      fill_in 'password', with: "testing"

      click_button 'Update Details'
      expect(page).to have_current_path('/users/aleksea_g/edit')
    end

    it 'allows a user to change their password' do
      visit '/login'
      fill_in 'username', with: 'aleksea_g'
      fill_in 'password', with: 'testing'
      click_button 'Login'

      visit '/users/aleksea_g/edit'

      fill_in 'new_password', with: "new"
      fill_in 'password_confirmation', with: "new"
      fill_in 'password', with: "testing"

      click_button 'Update Details'
      expect(page).to have_current_path('/divelogs/aleksea_g')

    end
  end

end
