class CreateUserCountries < ActiveRecord::Migration
  def change
    create_table :user_countries do |t|
      t.belongs_to :country, index: true
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
