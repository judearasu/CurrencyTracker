class User < ActiveRecord::Base
  # Associations

  has_many :user_currencies
  has_many :currencies, :through => :user_currencies

  has_many :user_countries
  has_many :countries,
           :through => :user_countries,
           :before_add => :add_all_currencies_of_country,
           :before_remove => :remove_all_currencies_of_country

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  def collect?(currency)
    currencies.exists?(currency)
  end

end
