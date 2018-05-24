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
      visit '/logout'
      visit '/login'
      fill_in 'username', with: "aleksea_g"
      fill_in 'password', with: 'testing'
      click_button 'Login'
      # params = {username: "aleksea_g", password: "testing"}
      # post '/login', params
      visit '/dives/new'
    end

    it 'loads the new dive page' do
      # expect(last_response.body).to include('Log a new dive')
      page.has_content?('Log a new dive')
    end

    it 'allows user to create a new dive' do
      # visit '/dives/new'
      # params = {date:'13/05/2016'}
      # post '/dives/create', params
      fill_in 'dive[date]', with: '13/05/2016'
      choose 'living-seas-at-epcot'
      click_button("Log Dive")
      expect(User.find_by_username("aleksea_g").dives.count).to eq(3)
    end

    it 'does not allow dive to have a empty date' do
      fill_in "dive[date]", with: ""
      click_button("Log Dive")
      page.has_content?('Choose a dive site or add a new one!')
    end

    it 'redirects to current users divelog if successfully added new dive' do
      fill_in "dive[date]", with: "15/13/2012"
      click_button("Log Dive")
      page.has_content?("Aleksea G's Dive Log")
      page.has_content?('15/13/2012')
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
      fill_in "dive[date]", with: "13/05/2016"
      click_button("Update Dive")
      expect(User.find_by_username("aleksea_g").dives.count).to eq(3)
    end

    it 'does not allow dive to have a empty date' do
      fill_in "dive[date]", with: ""
      click_button("Update Dive")
      expect(last_response.location).to include('/aleksea_g/ariels-grotto/17-04-2018/edit')
    end

    it 'does not allow a user to edit another users dive' do
      get '/logout'
      params = {username: "Gingertonic", password: "password"}
      post '/login', params
      get '/aleksea_g/ariels-grotto/17-04-2018/edit'
      expect(last_response.body).to_not include('Update Dive')
    end

    it 'redirects to current users divelog if successful edit' do
      fill_in "dive[date]", with: "12/12/2012"
      click_button("Update Dive")
      expect(last_response.location).to include('/divelogs/aleksea_g')
      expect(last_response.body).to include('12/12/2012')
    end
  end

  describe 'delete dive' do
    before(:each) do
      get '/logout'
      params = {username: "aleksea_g", password: "testing"}
      post '/login', params
      get '/aleksea_g/ariels-grotto/17-04-2018/edit'
    end

    it 'allows a user to delete a dive' do
      get '/aleksea_g/ariels-grotto/17-04-2018'
      click_button("Delete Dive")
      expect(Dive.find_by_user_divesite_and_date(user: aleksea_g, divesite: ariels-grotto, date: "17-04-2018")).to_not exist
    end

    it 'does not allow a user to delete another users dive' do
      get '/logout'
      params = {username: "Gingertonic", password: "password"}
      post '/login', params
      get '/aleksea_g/ariels-grotto/17-04-2018'
      expect(last_response.body).to_not include('Delete Dive')
    end
  end
end
