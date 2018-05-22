class Divesite < ActiveRecord::Base
  has_many :dive_divesites
  has_many :dives, through: :dive_divesites
  has_many :users, through: :dives

  def slug
    name.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    result = Divesite.all.select {|divesite| divesite.slug == slug}
    result.first
  end
end
