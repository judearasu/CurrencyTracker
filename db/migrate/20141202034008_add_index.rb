class AddIndex < ActiveRecord::Migration
	def up
		rename_column(:user_countries, :country_id, :country_code) 
		change_column(:user_countries, :country_code,:string)
		add_index :countries, :code, :unique => true
		add_index :currencies, :code, :unique => true
		add_index :user_countries, [:user_id, :country_code], :unique => true
		add_index :user_currencies, [:user_id, :currency_code], :unique => true
	end

	def down
		remove_index :countries, :code
		remove_index :currencies, :code
		remove_index :user_countries, [:user_id, :country_code]
		remove_index :user_currencies, [:user_id, :currency_code]
		rename_column(:user_countries, :country_code, :country_id) 
		change_column(:user_countries, :country_id,:integer)
	end
end
