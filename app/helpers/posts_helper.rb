module PostsHelper
    def get_number_of_topics_post_votes(topic_id, post_id)
        @votes = Vote.where(:topic_id => topic_id, :post_id => post_id).sum(:value)
        return @votes
    end

    def get_number_of_topics_post_votes_by_user_id
    end

    def did_user_vote_on_topic_post?(topic_id, post_id)
        if user_signed_in?
            return Vote.where(:topic_id => topic_id, :post_id => post_id, :user_id => current_user).exists?
        else
            return false
        end
    end
end
