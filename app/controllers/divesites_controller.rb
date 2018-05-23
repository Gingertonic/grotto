class DivesitesController < ApplicationController

  get '/divesites/:slug' do
    @divesite = Divesite.find_by_slug(params[:slug])
    erb :'divesites/show'
  end

end
