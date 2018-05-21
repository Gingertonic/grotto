class User < ActiveRecord::Base
  validates :first_name, :last_name, :username, :email, presence: true
  validates :email, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
