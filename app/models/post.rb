class Post < ActiveRecord::Base
  belongs_to :discussion
  belongs_to :user
  
  validates_presence_of     :body
  validates_presence_of     :discussion
  validates_presence_of     :user
  
  def valid
    self.user && Util.ne(post.body) && post.discussion && post.unique?
  end
  
  def unique?()
    unique = true
    for post in Post.find(:all, :conditions => "discussion_id = #{self.discussion.id} AND body = '#{self.body}'")
      if post.user.name == self.user.name
        unique = false
        break
      end
    end
    
    return unique
  end
end
