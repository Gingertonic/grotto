require 'spec_helper'

describe ApplicationController do

  describe 'homepage' do
    it 'loads the homepage' do
      get '/'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Welcome to the Grotto...")
    end
  end

  describe 'sign up page' do
    it 'loads the sign up page' do
      get '/signup'
      expect(last_response.body).to include("Create an account")
    end

    it 'directs new users to the feed of all users\' dives' do
      params = {first_name: "Beth", last_name: "Schofield", username: "Gingertonic", email: "thegingertonicstudios@gmail.com", password: "password"}
      post '/signup', params
      expect(last_response.location).to include("/dives")
    end

    it 'does not let a user sign up without a password' do
      params = {first_name: "Beth", last_name: "Schofield", username: "Gingertonic", email: "thegingertonicstudios@gmail.com"}
      post '/signup', params
      expect(last_response.location).to include("/signup")
    end

    it 'does not let a logged in user see the signup page' do
      user = User.create({first_name: "Beth", last_name: "Schofield", username: "Gingertonic", email: "thegingertonicstudios@gmail.com", password: "password"})
      params = {first_name: "Beth", last_name: "Schofield", username: "Gingertonic", email: "thegingertonicstudios@gmail.com", password: "password"}
      post '/signup', params
      session[:user_id] = user.id
      get '/signup'
      expect(last_response.location).to include("/dives")
    end
  end

  describe 'log in page' do
    before(:each) do
      visit '/login'
    end

    it 'goes to a page with a login form and submit button' do
      expect(page).to have_selector('form')
      expect(page).to have_selector('button')
    end

    it 'lets a user login' do
      fill_in("username"), with: "Gingertonic"
      fill_in("password"), with: "password"
      click_button("submit")
      expect(page).to have_content("Beti")
    end
  end

end
