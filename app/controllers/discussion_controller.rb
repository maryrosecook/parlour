class DiscussionController < ApplicationController

  def index
    redirect_to "/"
  end

  def show
    if cookies[:user_id]
      @user = User.find cookies[:user_id]
    else
      @user = User.new
    end
    
    if params[:identifier]
      discussion_identifier = params[:identifier]
      @post = Post.new
      @discussion = Discussion.find_by_identifier discussion_identifier
      #@discussion_created_by_current_user = @discussion && session[:created_discussions] && session[:created_discussions].include?(@discussion.id)
    end
  end
  
  def new
    if request.post?
      @discussion = Discussion.new(params[:discussion])
      if @discussion.save
        # store that this discussion was created by current user
        session[:created_discussions] = [] if !session[:created_discussions]
        session[:created_discussions] << @discussion.id
        
        redirect_to "/discussion/#{@discussion.identifier}"
      end
    else
      @discussion = Discussion.new
    end
  end
end