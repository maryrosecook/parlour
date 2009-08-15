module Linking
  
  def self.site_url
    if production?
      return Siting.live_url
    else
      return Siting.dev_url
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
  
  def self.at_url?(test_url, url)
    test_url == url
  end
end