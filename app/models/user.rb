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

  def visited?(country)
    self.countries.exists?(country)
  end
  def toggle_visiting(country)
    if visited?(country)
      countries.delete(country)
    else
      countries << country
    end
  end
  def update_collection(currency)
    if collect?(currency)
      currencies.delete(currency)
      update_country_visiting(currency.country)
    else
      currencies << currency
      single_collecting do
        self.countries << currency.country unless visited?(currency.country)
      end
    end
  end
  def add_all_currencies_of_country(country)
    self.currencies << country.currencies unless @single_collecting
  end

  def remove_all_currencies_of_country(country)
    self.currencies.delete(*country.currencies)
  end
  def single_collecting &block
    @single_collecting = true
    block.call
    @single_collecting = false
  end
  def update_country_visiting(country)
    all_currencies = country.currencies
    if (all_currencies & self.currencies).empty? && visited?(country)
      toggle_visiting(country)
    end
  end
end
