class User < ActiveRecord::Base
  has_many :posts
  
  def self.get_or_create(name)
    user = nil
    if name
      name = name.strip
      if name.length > 0
        user = User.find(:first, :conditions => "name = '#{name}'")
        if !user
          user = self.new
          user.name = name
        end
      end
    end
    
    return user
  end
end
