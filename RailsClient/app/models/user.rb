class User < ActiveRecord::Base

  validates_uniqueness_of :nr, :email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:nr]

end
