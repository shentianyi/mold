class User < ActiveRecord::Base
  validates_presence_of :nr, :message => "员工号不能为空!"
  validates_presence_of :user_name, :message => "用户名不能为空!"
  validates_presence_of :email, :message => "邮箱不能为空!"
  validates_presence_of :role_id, :message => "角色不能为空!"
  validates_presence_of :password, :message => "密码不能为空!"
  validates_presence_of :password_confirmation, :message => "密码验证不能为空!"
  validates_uniqueness_of :nr, :email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:nr]


  def method_missing(method_name, *args, &block)
    if Role::RoleMethods.include?(method_name)
      Role.send(method_name, self.role_id)
    else
      super
    end
  end

  def role
    Role.display(self.role_id)
  end

end
