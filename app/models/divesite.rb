class Divesite < ActiveRecord::Base
  validates :name, presence: true

  has_many :dives, :class_name => "Dive"
  has_many :users, through: :dives

  def self.incomplete_info?(params)
    !params[:dive][:divesite_id] && (!params[:new_site] || (params[:new_site][:name].empty? || params[:new_site][:location].empty? || params[:new_site][:country].empty?))
  end

  def self.incomplete_info_for_new?(params)
    params[:divesite][:name].empty? || params[:divesite][:location].empty?  || params[:divesite][:country].empty?
  end

  def destroyable?(current_user)
    affected_users = self.dives.map{|dive| dive.user}.uniq
    affected_users.count == 0 || (affected_users.count == 1 && affected_users.first == current_user)
  end

  def delete_site_and_related_dives
    self.dives.each {|dive| dive.destroy }
    self.destroy
  end

  def map_source
    "https://www.google.com/maps/embed/v1/search?key=AIzaSyCTvz6Gwbc_XUccsnJHBBGaLEn_IbZvWIY&q=dive+centers+in+#{self.location}+#{self.country}&zoom=10"
  end

  def self.sort_by_country
    self.all.sort_by{|site| site.country}
  end

  def self.all_countries
    self.all.map {|ds| ds.country.downcase}.uniq.sort
  end

  def slug
    country = self.country.downcase.split(" ").join("-").split(/[,!?*&#]/).join("")
    location = self.location.downcase.split(" ").join("-").split(/[,!?*&#]/).join("")
    name = self.name.downcase.split(" ").join("-").split(/[,!?*&#]/).join("")
    "#{country}/#{location}/#{name}"
  end

  def self.find_by_slug(params)
    # binding.pry
    result = Divesite.all.select {|ds| ds.slug == "#{params[:country].downcase.split(" ").join("-").split(/[,!?*&#]/).join("")}/#{params[:location].downcase.split(" ").join("-").split(/[,!?*&#]/).join("")}/#{params[:name].downcase.split(" ").join("-").split(/[,!?*&#]/).join("")}"}
    result.first
  end


end
