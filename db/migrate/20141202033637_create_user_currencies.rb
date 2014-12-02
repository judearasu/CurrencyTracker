class CreateUserCurrencies < ActiveRecord::Migration
  def change
    create_table :user_currencies do |t|
      t.references :user
      t.string :currency_code

      t.timestamps
    end
  end
end
