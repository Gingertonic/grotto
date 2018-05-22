require 'spec_helper'

describe User do
  before(:each) do
    @test_user = User.create({first_name: "Beth", last_name: "Schofield", username: "Ginger tonic", email: "thegingertonicstudios@gmail.com", password: "password"})
  end

  describe 'validation' do
    it 'has a first name, last name, username, email and password' do
      expect(@test_user).to be_valid
    end

    it 'is invalid without a first name' do
      user = User.create({last_name: "Schofield", username: "Ginger tonic", email: "thegingertonicstudios@gmail.com", password: "password"})

      expect(user).to_not be_valid
    end

    it 'is invalid without a last name' do
      user = User.create({first_name: "Beth", username: "Ginger tonic", email: "thegingertonicstudios@gmail.com", password: "password"})

      expect(user).to_not be_valid
    end

    it 'is invalid without a username' do
      user = User.create({first_name: "Beth", last_name: "Schofield", email: "thegingertonicstudios@gmail.com", password: "password"})

      expect(user).to_not be_valid
    end

    it 'is invalid without an email' do
      user = User.create({first_name: "Beth", last_name: "Schofield", username: "Ginger tonic", password: "password"})

      expect(user).to_not be_valid
    end

    it 'is invalid without a password' do
      user = User.create({first_name: "Beth", last_name: "Schofield", username: "Ginger tonic"})

      expect(user).to_not be_valid
    end

    it 'is invalid with a duplicate email' do
      @test_user
      user2 = User.create({first_name: "Beth", last_name: "Schofield", username: "BetiLeti", email: "thegingertonicstudios@gmail.com", password: "password"})
      expect(user2).to_not be_valid
    end
  end

  describe 'instance methods' do
    it 'a user knows its full name' do
      expect(@test_user.full_name).to eq("Beth Schofield")
    end

    it 'can create a slug from the username' do
      expect(@test_user.slug).to eq("ginger-tonic")
    end

  end

  describe 'class methods' do
    it 'can find a user from a slug of the username' do
      slug = "ginger-tonic"
      expect(User.find_by_slug(slug)).to eq(@test_user)
    end
  end

  describe 'associations' do
    it 'has many dives' do
      dive1 = @test_user.dives.build({date: "17/04/2018"})
      dive2 = @test_user.dives.build({date: "30/01/2017"})
      @test_user.save

      expect(@test_user.dives.count).to eq(2)
    end

    it 'has many divesites' do
      dive1 = @test_user.dives.build({date: "17/04/2018"})
      dive2 = @test_user.dives.build({date: "30/01/2017"})
      @test_user.save
      divesite1 = Divesite.create({name: "Ariels Grotto"})
      divesite2 = Divesite.create({name: "Living Seas at Epcot"})
      dive1.divesite = divesite1
      dive2.divesite = divesite2
      dive1.save
      dive2.save

      expect(@test_user.divesites.count).to eq(2)
    end
  end

end
