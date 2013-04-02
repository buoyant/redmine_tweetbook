class CreateTweetBooks < ActiveRecord::Migration
  def self.up
    create_table :tweet_books do |t|
      t.string  :uid
      t.string  :provider
      t.string  :name
      t.string  :nickname      
      t.string  :email
      t.string  :image
      t.integer :user_id
      t.datetime :created_on
    end
  end

  def self.down
    drop_table :tweet_books
  end
end
