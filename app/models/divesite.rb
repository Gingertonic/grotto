class Divesite < ActiveRecord::Base
  validates :name, presence: true

  has_many :dives, :class_name => "Dive"
  has_many :users, through: :dives

  # def slug
  #   name.downcase.split(" ").join("-")
  # end

  def slug
    country = self.country.downcase.split(" ").join("-").split(/[,!?*&#]/).join("")
    location = self.location.downcase.split(" ").join("-").split(/[,!?*&#]/).join("")
    name = self.name.downcase.split(" ").join("-").split(/[,!?*&#]/).join("")
    "#{country}/#{location}/#{name}"
  end

  # def self.find_by_slug(slug)
  #   result = Divesite.all.select {|divesite| divesite.slug == slug}
  #   result.first
  # end

  def self.find_by_slug(params)
    result = Divesite.all.select {|ds| ds.slug == "#{params[:country].downcase}/#{params[:location].downcase}/#{params[:name].downcase}"}
    result.first
  end

end
