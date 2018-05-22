require 'spec_helper'

describe Divesite do
  before(:each) do
    @test_divesite = Divesite.create(name: "Ariels Grotto")
  end

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

    it 'has many divers (Users)'

    it 'has many dives'

  end

  describe 'instance methods' do
    it 'can create a slug from the divesite name' do
      expect(@test_divesite.slug).to eq("Ariels-Grotto")
    end
  end

  describe 'class methods' do
    it 'can find a divesite from its slug' do
      slug = "Ariels-Grotto"
      expect(Divesite.find_by_slug(slug)).to eq(@test_divesite)
    end
  end

end
