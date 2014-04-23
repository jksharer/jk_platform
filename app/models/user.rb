class User < ActiveRecord::Base
  belongs_to :agency
  has_secure_password

  validates :username, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :password, length: { in: 3..20 }
  validates :agency, presence: true

  has_and_belongs_to_many :roles, -> { uniq }, :join_table => 'users_roles'

end