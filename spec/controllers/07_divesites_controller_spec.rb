require 'spec_helper'

describe DivesitesController do
  before(:each) do
    @beti = User.create({first_name: "Beth", last_name: "Schofield", username: "Gingertonic", email: "thegingertonicstudios@gmail.com", password: "password"})
    aki = User.create({first_name: "Aleksandar", last_name: "Gakovic", username: "aleksea_g", email: "al@bear.com", password: "testing"})
    dive1 = Dive.create(date: "17/04/2018")
    dive2 = Dive.create(date: "01/30/2017")
    grotto = Divesite.create(name: "Ariels Grotto", location: "Menjangan Island, Bali", country: "Indonesia")
    epcot = Divesite.create(name: "Living Seas at Epcot", location: "Disneyworld", country: "USA")
    dive1.user = aki
    dive1.divesite = grotto
    dive1.save
    dive2.user = aki
    dive2.divesite = epcot
    dive2.save
  end

  after do
    User.destroy_all
    Dive.destroy_all
    Divesite.destroy_all
  end

  describe 'divesite show page' do
    it 'shows information on 1 divesite' do
      params = {username: "aleksea_g", password: "testing"}
      post '/login', params
      get '/divesites/ariels-grotto'
      expect(last_response.body).to include("Ariels Grotto")
      expect(last_response.body).to_not include("Living Seas at Epcot")
    end

    it 'shows a list of all divers who have dived this site' do
      dive3 = Dive.create(date: "01/30/2017")
      dive3.user = @beti
      params = {username: "aleksea_g", password: "testing"}
      post '/login', params
      get '/divesites/ariels-grotto'
      expect(last_response.body).to include("aleksea_g")
      expect(last_response.body).to_not include("Gingertonic")
    end
  end

end
