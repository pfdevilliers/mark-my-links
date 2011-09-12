class Post < ActiveRecord::Base
    has_many :votes
    belongs_to :topic
    belongs_to :user
end
