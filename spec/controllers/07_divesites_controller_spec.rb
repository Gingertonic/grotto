require 'spec_helper'

describe DivesitesController do
  before(:each) do
    @beti = User.create({first_name: "Beth", last_name: "Schofield", username: "beti_leti", email: "thegingertonicstudios@gmail.com", password: "password"})
    aki = User.create({first_name: "Aleksandar", last_name: "Gakovic", username: "aleksea_g", email: "al@bear.com", password: "testing"})
    dive1 = Dive.create(date: "17/04/2018", notes: "")
    dive2 = Dive.create(date: "01/30/2017", notes: "")
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
    before(:each) do
      dive3 = Dive.create(date: "01/30/2017", divesite_id: 2)
      dive3.user = @beti
      dive3.save
      params = {username: "aleksea_g", password: "testing"}
      post '/login', params
      get '/divesites/indonesia/menjangan-island-bali/ariels-grotto'
    end

    it 'shows information on 1 divesite' do
      expect(last_response.body).to include("Ariels Grotto")
      expect(last_response.body).to_not include("Living Seas at Epcot")
    end

    it 'shows a list of all divers who have dived this site' do
      expect(last_response.body).to include("aleksea_g")
      expect(last_response.body).to_not include("Beti Leti")
    end
  end

  describe 'new divesite page'do
    before(:each) do
      visit '/logout'
      visit '/login'
      fill_in 'username', with: "aleksea_g"
      fill_in 'password', with: 'testing'
      click_button 'Login'
      visit '/divesites/new'
    end

    it 'shows a form with a submit button' do
      expect(page).to have_selector("form")
      expect(page).to have_button("Add Divesite")
    end

    it 'allows user to create a new divesite' do
      fill_in "divesite[name]", with: "Tritons Castle"
      fill_in "divesite[location]", with: "Under the Sea"
      fill_in "divesite[country]", with: "Disney Universe"
      click_button("Add Divesite")
      expect(Divesite.all.count).to eq(3)
    end

    it 'does not allow divesite to have a empty name' do
      fill_in "divesite[location]", with: "Under the Sea"
      fill_in "divesite[country]", with: "Disney Universe"
      click_button("Add Divesite")
      expect(page).to have_current_path('/divesites/new')
    end

    it 'redirects to list of divesites if successfully added new divesite' do
      fill_in "divesite[name]", with: "Tritons Castle"
      fill_in "divesite[location]", with: "Under the Sea"
      fill_in "divesite[country]", with: "Disney Universe"
      click_button("Add Divesite")
      expect(page).to have_current_path('/divesites/disney-universe/under-the-sea/tritons-castle')
      expect(page).to have_content('Tritons Castle')
    end
  end

  describe 'edit dive page'do
    before(:each) do
      visit '/logout'
      visit '/login'
      fill_in 'username', with: "aleksea_g"
      fill_in 'password', with: 'testing'
      click_button 'Login'
      visit '/divesites/indonesia/menjangan-island-bali/ariels-grotto/edit'
    end

    it 'shows a form with a submit button' do
      expect(page).to have_selector("form")
      expect(page).to have_button("Update Dive")
    end

    it 'allows user to edit a dive' do
      fill_in "divesite[country]", with: "Disney Universe"
      click_button("Update Divesite")
      expect(Divesite.find(1).country).to eq("Disney Universe")
    end

    it 'does not allow dive to have a empty name' do
      fill_in "divesite[name]", with: ""
      click_button("Update Divesite")
      expect(page).to have_current_path('/divesites/indonesia/menjangan-island-bali/ariels-grotto/edit')
    end

    it 'redirects to list of divesites if successfully edited divesite' do
      fill_in "divesite[name]", with: "Ariels Cave"
      click_button("Update Divesite")
      expect(page).to have_current_path('/divesites/indonesia/menjangan-island-bali/ariels-cave')
      expect(page).to have_content("Ariels Cave")
    end
  end

end
