class Divesite < ActiveRecord::Base
  validates :name, presence: true

  has_many :dives, :class_name => "Dive"
  has_many :users, through: :dives

  def self.incomplete_info?(params)
    !params[:dive][:divesite_id] && (!params[:new_site] || (params[:new_site][:name].empty? || params[:new_site][:location].empty? || params[:new_site][:country].empty?))
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
