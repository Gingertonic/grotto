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
      expect(last_response.body).to include("Create an account")
    end

    it 'directs new users to the feed of all users\' dives' do
      params = {first_name: "New", last_name: "User", username: "newuser", email: "new@user.com", password: "password"}
      post '/create', params
      expect(last_response.location).to include("/dives")
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
      get '/aleksea_g/edit'
    end

    it 'shows a form with a submit button' do
      expect(page).to have_selector("form")
      expect(page).to have_selector("button")
    end

    it 'allows user to update their details' do
      fill_in "last_name", with: "Schofield"
      fill_in "password", with: "testing"
      click_button("Update Your Details")
      expect(User.find_by_username("aleksea_g").last_name).to eq("Schofield")
    end

    it 'does not allow user to have an empty email' do
      fill_in "email", with: ""
      fill_in "password", with: "testing"
      click_button("Update Your Details")
      expect(last_response.location).to include('/aleksea_g/edit')
    end

    it 'does not allow a user to edit another users details' do
      get '/logout'
      params = {username: "Gingertonic", password: "password"}
      post '/login', params
      get '/divelogs/aleksea_g'
      fill_in "first_name", with: "Bobby"
      fill_in "password", with: "testing"
      click_button("Update Your Details")
      expect(last_response.location).to include('/aleksea_g/edit')
    end

    it 'redirects to current users divelog if successful edit' do
      fill_in "first_name", with: "Alek"
      fill_in "password", with: "testing"
      click_button("Update Your Details")
      expect(last_response.location).to include('/divelogs/aleksea_g')
      expect(User.find_by_username("aleksea_g").first_name).to eq("Alek")
    end

    it 'does not allow any changes with invalid password' do
      fill_in "email", with: "aki@do.com"
      fill_in "password", with: "wrongpassword"
      click_button("Update Your Details")
      expect(last_response.location).to include('/aleksea_g/edit')
      expect(User.find_by_username("aleksea_g").email).to eq("al@bear.com")
    end
  end

end
