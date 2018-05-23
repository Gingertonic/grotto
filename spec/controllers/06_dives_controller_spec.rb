require 'spec_helper'

describe DivesController do
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
    dive2.user = aki
    dive2.divesite = epcot
    dive2.save
  end

  after do
    User.destroy_all
    Dive.destroy_all
    Divesite.destroy_all
  end

  describe 'dive page' do

    it 'shows information on 1 dive'do
      params = {username: "aleksea_g", password: "testing"}
      post '/login', params
      get '/aleksea_g/ariels-grotto/17-04-2018'
      expect(last_response.body).to include("Ariels Grotto")
      expect(last_response.body).to_not include("Living Seas at Epcot")
    end
  end

  describe 'new dive page'do
    before(:each) do
      get '/logout'
      params = {username: "aleksea_g", password: "testing"}
      post '/login', params
      get '/dives/new'
    end

    it 'shows a form with a submit button' do
      expect(page).to have_selector("form")
      expect(page).to have_selector("submit")
    end

    it 'allows user to create a new dive' do
      fill_in "date", with: "13/05/2016"
      click_button("Log Dive")
      expect(User.find_by_username("aleksea_g").dives.count).to eq(3)
    end

    it 'does not allow dive to have a empty date' do
      fill_in "date", with: ""
      click_button("Log Dive")
      expect(last_response.location).to include('/dives/new')
    end

    it 'redirects to current users divelog if successfully added new dive' do
      fill_in "date", with: "15/13/2012"
      click_button("Log Dive")
      expect(last_response.location).to include('/divelogs/aleksea_g')
      expect(last_response.body).to include('15/13/2012')
    end
  end

  describe 'edit dive page'do
    before(:each) do
      get '/logout'
      params = {username: "aleksea_g", password: "testing"}
      post '/login', params
      get '/aleksea_g/ariels-grotto/17-04-2018/edit'
    end

    it 'shows a form with a submit button' do
      expect(page).to have_selector("form")
      expect(page).to have_selector("button")
    end

    it 'allows user to edit a dive' do
      fill_in "date", with: "13/05/2016"
      click_button("Update Dive")
      expect(User.find_by_username("aleksea_g").dives.count).to eq(3)
    end

    it 'does not allow dive to have a empty date' do
      fill_in "date", with: ""
      click_button("Update Dive")
      expect(last_response.location).to include('/aleksea_g/ariels-grotto/17-04-2018/edit')
    end

    it 'redirects to current users divelog if successful edit' do
      fill_in "date", with: "12/12/2012"
      click_button("Update Dive")
      expect(last_response.location).to include('/divelogs/aleksea_g')
      expect(last_response.body).to include('12/12/2012')
    end
  end
end
