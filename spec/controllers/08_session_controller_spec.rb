require 'spec_helper'

describe SessionController do
  before do
    beti = User.create({first_name: "Beth", last_name: "Schofield", username: "Gingertonic", email: "thegingertonicstudios@gmail.com"})
    aki = User.create({first_name: "Aleksandar", last_name: "Gakovic", username: "aleksea_g", email: "al@bear.com"})
    dive1 = Dive.create(date: "17/04/2018")
    dive2 = Dive.create(date: "01/30/2017")
    grotto = Divesite.create(name: "Ariels Grotto", location: "Menjangan Island, Bali", country: "Indonesia")
    epcot = Divesite.create(name: "Living Seas at Epcot", location: "Disneyworld", country: "USA")
    dive1.user = aki
    dive1.divesite = grotto
    dive1.save
  end

  after do
    User.destroy_all
    Dive.destroy_all
    Divesite.destroy_all
  end

  describe 'login' do
    it 'loads the sign up page' do
      get '/login'
      expect(last_response.status).to include("Login to the Grotto")
    end

    it 'loads all dives after login' do
      user = User.create({first_name: "Aleksandar", last_name: "Gakovic", username: "aleksea_g", email: "al@bear.com", password: "testing"})
      params = {username: "aleksea_g", password: "testing"}
      post '/login', params
      expect(last_response.status).to eq(302)
      follow_redirect!
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Welcome inside!")
    end

    it 'does not let a logged in user see the login page' do
      user = User.create({first_name: "Aleksandar", last_name: "Gakovic", username: "aleksea_g", email: "al@bear.com", password: "testing"})
      params = {username: "aleksea_g", password: "testing"}
      post '/login', params
      session[:user_id] = user.id
      get '/login'
      expect(last_response.location).to include("/dives")
    end
  end

  describe '/logout' do
    it 'lets a user logout' do
      user = User.create({first_name: "Aleksandar", last_name: "Gakovic", username: "aleksea_g", email: "al@bear.com", password: "testing"})
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
