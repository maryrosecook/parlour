module Linking
  
  def self.site_url
    if production?
      return "http://parlour.com"
    else
      return "http://localhost:3000"
    end
  end
  
  def self.current_url_for_display(request)
    current_url(request).gsub(/http:\/\//, "")
  end
  
  def self.current_url(request)
    site_url + request.request_uri
  end
  
  def self.production?
    ENV["RAILS_ENV"] == "production"
  end
end