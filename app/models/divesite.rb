class Divesite < ActiveRecord::Base
  validates :name, presence: true

  has_many :dives, :class_name => "Dive"
  has_many :users, through: :dives

  def slug
    name.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    result = Divesite.all.select {|divesite| divesite.slug == slug}
    result.first
  end
end
