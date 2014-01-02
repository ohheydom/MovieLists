class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
		 

  has_one :profile
  has_many :connectors
  has_many :movies, through: :connectors	
  
  validates :username, presence: true, uniqueness: true, format: {without: /\A\d/ }, length: 
	          { maximum: 12, too_long: "%{count} characters is the maximum allowed" }
	
	
  def to_param
    username
  end
  
  def self.find(input)
	  if input.to_i != 0
		  super
	  else
	    find_by_username(input)
    end
  end
  
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
	  if login = conditions.delete(:username)
	    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
	  else
      where(conditions).first
    end
  end

end
