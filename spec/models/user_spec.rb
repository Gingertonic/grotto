require 'spec_helper'

describe User do

  it 'has a first name, last name, username and email' do
    user = User.new({first_name: "Beth", last_name: "Schofield", username: "Gingertonic", email: "thegingertonicstudios@gmail.com"})

    expect(user).to be_valid
  end

end
