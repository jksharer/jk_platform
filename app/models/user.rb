class User < ActiveRecord::Base
  has_secure_password

  belongs_to :agency
  belongs_to :department
  has_many :steps
  has_many :announcements

  validates :username, presence: true, uniqueness: true, length: { maximum: 20 }
  validates :password, length: { in: 3..20 }
  validates :agency, presence: true

  has_and_belongs_to_many :roles, -> { uniq }, :join_table => 'users_roles'


  # 获取用户所拥有角色下的所有菜单权限
  def permissions
  	permissions = []
  	self.roles.each	do |role|
  		permissions |= role.menus
  	end
  	return permissions
  end

  def one_level_menus
  	permissions.find_all { |menu| menu.parent_menu.nil? }
  end

  # 获取用户某个一级菜单下的二级菜单权限
	def sub_menus(parent_menu)
		parent_menu.sub_menus & permissions
	end  

end