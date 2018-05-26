require 'spec_helper'

describe Divesite do
  before(:each) do
    @test_divesite = Divesite.create(name: "Ariels Grotto", location: "Under the Sea", country: "Disney Universe")
  end

  # after do
  #   Divesite.destroy_all
  #   User.destroy_all
  #   Dive.destroy_all
  # end

  describe 'validation' do

    it 'has a name' do
      expect(@test_divesite).to be_valid
    end

    it 'is invalid withoue a name' do
      divesite = Divesite.create

      expect(divesite).to_not be_valid
    end

  end

  describe 'associations' do

    it 'has many divers (Users)' do
      beti = User.create({first_name: "Beth", last_name: "Schofield", username: "Ginger tonic", email: "thegingertonicstudios@gmail.com", password: "password"})
      aki = User.create({first_name: "Test", last_name: "User", username: "test user", email: "testing@gmail.com", password: "test"})
      dive1 = beti.dives.create({date: "17/04/2018"})
      dive2 = aki.dives.create({date: "30/01/2017"})
      beti.save
      aki.save
      dive1.divesite = @test_divesite
      dive2.divesite = @test_divesite
      dive1.save
      dive2.save
      expect(@test_divesite.users.count).to eq(2)
    end


    it 'has many dives' do
      beti = User.create({first_name: "Beth", last_name: "Schofield", username: "Ginger tonic", email: "thegingertonicstudios@gmail.com", password: "password"})
      aki = User.create({first_name: "Test", last_name: "User", username: "test user", email: "testing@gmail.com", password: "test"})
      dive1 = beti.dives.create({date: "17/04/2018"})
      dive2 = aki.dives.create({date: "30/01/2017"})
      beti.save
      aki.save
      dive1.divesite = @test_divesite
      dive2.divesite = @test_divesite
      dive1.save
      dive2.save
      expect(@test_divesite.dives.count).to eq(2)
    end
  end

  describe 'instance methods' do
    it 'can create a slug from the divesite name' do
      expect(@test_divesite.slug).to eq("disney-universe/under-the-sea/ariels-grotto")
    end
  end

  describe 'class methods' do
    it 'can find a divesite from its slug' do
      params = {name: "Ariels Grotto", location: "Under the Sea", country: "Disney Universe"}
      expect(Divesite.find_by_slug(params)).to eq(@test_divesite)
    end
  end

end
