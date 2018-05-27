require 'spec_helper'

describe SessionController do
  before(:each) do
    @beti = User.create({first_name: "Beth", last_name: "Schofield", username: "Gingertonic", email: "thegingertonicstudios@gmail.com", password: "password"})
    @aki = User.create({first_name: "Aleksandar", last_name: "Gakovic", username: "aleksea_g", email: "al@bear.com", password: "testing"})
    dive1 = Dive.create(date: "17/04/2018")
    dive2 = Dive.create(date: "01/30/2017")
    grotto = Divesite.create(name: "Ariels Grotto", location: "Menjangan Island, Bali", country: "Indonesia")
    epcot = Divesite.create(name: "Living Seas at Epcot", location: "Disneyworld", country: "USA")
    dive1.user = @aki
    dive1.divesite = grotto
    dive1.save
  end

  after do
    User.destroy_all
    Dive.destroy_all
    Divesite.destroy_all
  end

  describe 'login' do
    it 'loads the login page' do
      get '/login'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Enter the")
    end

    describe 'log in page' do
      before(:each) do
        visit '/logout'
        visit '/login'
      end

      it 'goes to a page with a login form' do
        expect(page).to have_selector('form')
      end

      it 'lets a user login' do
        fill_in "username", with: "aleksea_g"
        fill_in "password", with: "testing"
        click_button("Login")
        expect(page).to have_content("Aleksea G")
      end
    end

    it 'loads all dives after login' do
      params = {username: "aleksea_g", password: "testing"}
      post '/login', params
      expect(last_response.location).to include("/dives")
    end

    it 'does not let a logged in user see the login page' do
      params = {username: "aleksea_g", password: "testing"}
      post '/login', params
      get '/login'
      expect(last_response.location).to include("/dives")
    end
  end

  describe '/logout' do
    it 'lets a user logout' do
      params = {username: "aleksea_g", password: "testing"}
      post '/login', params
      get '/logout'
      expect(last_response.location).to include("/login")
    end

    it 'does not give access to dives if not logged in' do
      get '/dives'
      expect(last_response.location).to include("/")
    end
  end


end
