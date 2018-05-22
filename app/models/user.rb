class User < ActiveRecord::Base
  validates :first_name, :last_name, :username, :email, :password, presence: true
  validates :email, uniqueness: true
  has_secure_password
  has_many :dives
  has_many :divesites, through: :dives

  def full_name
    "#{first_name} #{last_name}"
  end

  def slug
    username.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    result = User.all.select {|user| user.slug == slug}
    result.first
  end

end
