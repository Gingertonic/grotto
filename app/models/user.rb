class User < ActiveRecord::Base
  validates :first_name, :last_name, :username, :email, :password, presence: true
  validates :email, uniqueness: true
  attribute :image_url, :string, default: "https://upload.wikimedia.org/wikipedia/commons/c/c0/Hobby_diver.jpg"
  has_secure_password

  has_many :dives, :class_name => "Dive"
  has_many :divesites, through: :dives


  def self.invalid?(params)
    user = User.find_by_username(params[:username])
    params[:username].empty? || user
  end

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

  def self.invalid_image?(image_url)
    !image_url.match(/\S*\.((jpg)|(gif)|(png))\z/i)
  end

  def smart_update(params)
    params.each {|k, v| self.update(k => v, "password" => params[:password]) if !!self[k]}
  end

  def update_password(params)
    self.password = params[:new_password]
    self.save
  end

end
