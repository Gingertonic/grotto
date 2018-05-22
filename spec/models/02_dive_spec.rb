require 'spec_helper'

describe Dive do
  before(:each) do
    @test_dive = Dive.create({date: "17/04/2018", time: "10:00", length: 50})
  end

  describe 'validation' do
    it 'has a date, time and length' do
      expect(@test_dive).to be_valid
    end

    it 'is invalid without a date' do
      dive = Dive.new({time: "10:00", length: 50})

      expect(dive).to_not be_valid
    end

  end

  describe 'associations' do
    it 'belongs to a user' do
      @test_dive.user = User.create({first_name: "Beth", last_name: "Schofield", username: "Gingertonic", email: "thegingertonicstudios@gmail.com", password: "password"})

      expect(@test_dive.user.username).to eq("Gingertonic")
    end

    it 'belongs to a Divesite' do
      @test_dive.divesite = Divesite.new(name: "Ariels Grotto")

      expect(@test_dive.divesite.name).to eq("Ariels Grotto")
    end

  end

  describe 'properties' do

    it 'can have notes' do
      @test_dive.notes = "The most special of dives"
      @test_dive.save

      expect(@test_dive.notes).to eq("The most special of dives")
    end

  end

  describe 'instance methods' do

    it 'can print its date in full format' do
      expect(@test_dive.full_date).to eq("April the 17th, 2018")
    end

  end
end
