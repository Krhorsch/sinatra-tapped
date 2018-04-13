class User < ActiveRecord::Base
  has_many :beers

  def self.all_usernames
    self.all.collect do |x|
      x.username
    end
  end

  def self.all_emails
    self.all.collect do |x|
      x.email
    end
  end
end
