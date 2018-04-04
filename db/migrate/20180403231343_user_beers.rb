class UserBeers < ActiveRecord::Migration[5.1]
  def change
    create_table :user_beers do |t|
      t.integer :user_id
      t.integer :beer_id
    end
  end
end
