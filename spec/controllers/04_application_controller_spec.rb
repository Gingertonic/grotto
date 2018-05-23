require 'spec_helper'

describe ApplicationController do


  describe 'homepage' do
    it 'loads the homepage' do
      get '/'
      expect(last_response.status).to eq(200)
      expect(last_response.body).to include("Welcome to the Grotto...")
    end
  end



end
