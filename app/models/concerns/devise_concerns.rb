module DeviseConcerns
  extend ActiveSupport::Concern

  included do
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
  end

  def to_param
    username
  end

  module ClassMethods
    def find(input)
      if input.to_i != 0
        super
      else
        find_by_username(input)
      end
    end

    def find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:username)
        where(conditions).where(['lower(username) = :value OR lower(email) = :value', { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end
  end
end
