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

  describe 'divesite index page' do
    it 'loads a page listing all divesites' do
      params = {username: "aleksea_g", password: "testing"}
      post '/login', params
      get '/divesites'
      expect(last_response.body).to include("All Divesites")
    end
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

  describe 'new divesite page'do
    before(:each) do
      get '/logout'
      params = {username: "aleksea_g", password: "testing"}
      post '/login', params
      get '/divesites/new'
    end

    it 'shows a form with a submit button' do
      expect(page).to have_selector("form")
      expect(page).to have_selector("submit")
    end

    it 'allows user to create a new divesite' do
      fill_in "name", with: "Tritons Castle"
      fill_in "location", with: "Under the Sea"
      fill_in "country", with: "Disney Universe"
      click_button("Add Divesite")
      expect(Divesite.all.count).to eq(3)
    end

    it 'does not allow dive to have a empty name' do
      fill_in "location", with: "Under the Sea"
      fill_in "country", with: "Disney Universe"
      click_button("Add Divesite")
      expect(last_response.location).to include('/divesite/new')
    end

    it 'redirects to list of divesites if successfully added new divesite' do
      fill_in "name", with: "Tritons Castle"
      fill_in "location", with: "Under the Sea"
      fill_in "country", with: "Disney Universe"
      click_button("Add Divesite")
      expect(last_response.location).to include('/divesites')
      expect(last_response.body).to include('Tritons Castle')
    end
  end

  describe 'edit dive page'do
    before(:each) do
      get '/logout'
      params = {username: "aleksea_g", password: "testing"}
      post '/login', params
      get '/divesites/ariels-grotto/edit'
    end

    it 'shows a form with a submit button' do
      expect(page).to have_selector("form")
      expect(page).to have_selector("button")
    end

    it 'allows user to edit a dive' do
      fill_in "country", with: "Disney Universe"
      click_button("Update Divesite")
      expect(Divesite.find_by_slug("ariels-grotto").country).to eq("Disney Universe")
    end

    it 'does not allow dive to have a empty name' do
      fill_in "name", with: ""
      click_button("Update Divesite")
      expect(last_response.location).to include('/divesites/ariels-grotto/edit')
    end

    it 'redirects to list of divesites if successfully edited divesite' do
      fill_in "name", with: "Ariels Cave"
      click_button("Update Divesite")
      expect(last_response.location).to include('/divesites')
      expect(last_response.body).to include("Ariels Cave")
    end
  end

end
