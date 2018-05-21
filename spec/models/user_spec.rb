require 'spec_helper'

describe User do

  it 'has a first name, last name, username and email' do
    user = User.new({first_name: "Beth", last_name: "Schofield", username: "Gingertonic", email: "thegingertonicstudios@gmail.com"})

    expect(user).to be_valid
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
    user1 = User.create({first_name: "Beth", last_name: "Schofield", username: "Gingertonic", email: "thegingertonicstudios@gmail.com"})
    user2 = User.create({first_name: "Beth", last_name: "Schofield", username: "BetiLeti", email: "thegingertonicstudios@gmail.com"})

    expect(user2).to_not be_valid
  end

  it 'a user knows its full name' do
    user = User.create({first_name: "Beth", last_name: "Schofield", username: "Gingertonic", email: "thegingertonicstudios@gmail.com"})

    expect(user.full_name).to eq("Beth Schofield")
  end
end
