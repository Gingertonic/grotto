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

  describe 'user homepage' do
    it 'shows only 1 users dives' do
      params = {username: aleksea_g, password: testing}
      post '/login', params
      get '/aki'
      expect(last_response.body).to include("Ariels Grotto")
      expect(last_response.body).to_not include("Living Seas at Epcot")
    end
  end

end
