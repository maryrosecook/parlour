module Util

  def self.ne(str)
    str && str != ""
  end
  
  def self.strip_html(str)
    str.gsub(/<\/?[^>]*>/, "")
  end
  
  def self.esc_speech(str)
    str = str.gsub(/"/, '\"')
  end
  
  # shorts passed str to passed word_count
  def self.truncate(str, word_count, elipsis)
    words = str.split()
    truncated_str = str.split[0..(word_count-1)].join(" ")
    if elipsis && words.length() > word_count
      truncated_str += "..."
    end
    
    truncated_str
  end
  
  # returns random element of array
  def self.rand_el(array)
    el = nil
    el = array[rand()*(array.length-1)] unless !array || array.length < 1
    return el
  end
  
  # returns true and logs out of time error if started + max_time > now
  def self.out_of_time(started, max_time, desc, log)
    out_of_time = false
    if Time.new().tv_sec > started.tv_sec + max_time # kill the process if more than UPDATE_ARTIST_DETAILS_MAX_TIME old
      out_of_time = true
      Log::log(nil, nil, Log::OUT_OF_TIME, nil, desc) if log
    end
      
    out_of_time
  end
  
  def self.parse_js_response(request)
    word_raw = request.raw_post || request.query_string
    word_raw = word_raw.gsub(/(.*)authenticity_token.*/, "\\1")
    word_raw.gsub(/&/, "")
  end
  
  def self.f_date(date)
    date.strftime("%d.%m.%y") if date
  end
  
  def self.f_date_time(date)
    date.strftime("%d.%m.%y %H:%M") if date
  end
end