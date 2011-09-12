module TopicsHelper
    def calculate_time_since_post(time)
        difftime = DateTime.current.to_i - time.to_datetime.to_i

        puts difftime

        format = ""
        if difftime < (24*60*60)
            sec = difftime % 60;
            min = (difftime - sec) % (60**2)
            hour = (difftime - min - sec) % (60**2 * 24)
            format = (hour/(60**2)).to_s + "h " + (min/60).to_s + "m " + sec.to_s + "s ago"
        else
            days = difftime / (24*60*60);
            format = pluralize(days, "day") + " ago"
        end
        return format 
    end

    def get_number_of_topic_views(topic_id)
        return View.find_all_by_topic_id(topic_id).count
    end

    def get_word_plural(count, word)
        msg = pluralize(count, word)
        length = count.to_s.size
        return msg[(length+1)..-1]
    end
end
