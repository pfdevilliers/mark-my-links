class Topic < ActiveRecord::Base
    has_many :posts
    has_many :votes
    has_many :views
    belongs_to :user
end
