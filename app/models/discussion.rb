class Discussion < ActiveRecord::Base
  has_many :posts
  
  validates_presence_of     :title
  validates_length_of       :title, :within => 1..100
  
  before_save :generate_identifier
  
  def generate_identifier    
    if self.title
      base_identifier = self.title.downcase.gsub(/\W/, "")
      identifier_try = base_identifier

      i = 1
      while Discussion.find_by_identifier(identifier_try)
        identifier_try = base_identifier + i.to_s
        i += 1
      end

      self.identifier = identifier_try
    end
  end
  
  def posts
    Post.find(:all, :conditions => "discussion_id = #{self.id}", :order => 'created_at ASC')
  end
end
