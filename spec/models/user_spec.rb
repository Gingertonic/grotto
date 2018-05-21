require 'spec_helper'

describe User do
  before(:each) do
    @test_user = User.create({first_name: "Beth", last_name: "Schofield", username: "Gingertonic", email: "thegingertonicstudios@gmail.com"})
    @test_slug_user = User.create({first_name: "Beth", last_name: "Schofield", username: "ginger tonic", email: "thegingertonicstudios@gmail.com"})
  end

  describe 'validation' do
    it 'has a first name, last name, username and email' do
      expect(@test_user).to be_valid
    end

    it 'is invalid without a first name' do
      user = User.create({last_name: "Schofield", username: "Gingertonic", email: "thegingertonicstudios@gmail.com"})

      expect(user).to_not be_valid
    end

    it 'is invalid without a last name' do
      user = User.create({first_name: "Beth", username: "Gingertonic", email: "thegingertonicstudios@gmail.com"})

      expect(user).to_not be_valid
    end

    it 'is invalid without a username' do
      user = User.create({first_name: "Beth", last_name: "Schofield", email: "thegingertonicstudios@gmail.com"})

      expect(user).to_not be_valid
    end

    it 'is invalid without an email' do
      user = User.create({last_name: "Schofield", username: "Gingertonic"})

      expect(user).to_not be_valid
    end

    it 'is invalid with a duplicate email' do
      @test_user
      user2 = User.create({first_name: "Beth", last_name: "Schofield", username: "BetiLeti", email: "thegingertonicstudios@gmail.com"})
      expect(user2).to_not be_valid
    end
  end

  describe 'instance methods' do
    it 'a user knows its full name' do
      expect(@test_user.full_name).to eq("Beth Schofield")
    end

    it 'can create a slug from the username' do
      expect(@test_user.slug).to eq("Ginger-Tonic")
    end
  end

  describe 'associations' do
    it 'has many dives' do
      dive1 = @test_user.dives.build("Dive 1")
      dive2 = @test_user.dives.build("Dive 2")

      expect(user.dives.count).to eq(2)
    end

    it 'has many divesites'

  end

end
