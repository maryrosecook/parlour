class PostController < ApplicationController

  def add
    # create user
    user = nil
    if params[:user]
      user = User.get_or_create(params[:user][:name])
    end
    
    # create discussion
    discussion = nil
    discussion = Discussion.find(params[:discussion][:id]) if params[:discussion]

    # create post
    post = Post.new(params[:post])
    post.user = user
    post.discussion = discussion
    
    if post.valid? # if all well proceed to save
      if post.save
        cookies[:user_id] = user.id.to_s
        render :update do |page|
          JSUtil.blank_elements(page, ["user_name_error", "post_body_error", "post_body_error"])
          page.insert_html :bottom, 'posts', :partial => 'show', :locals => { :post => post }
          page.visual_effect :highlight, "post#{post.id}", :duration => 4
          page.replace_html 'nothing_said', "" if post.discussion.posts.length == 1
        end
      end
    else
      render :update do |page|
        JSUtil.blank_elements(page, ["user_name_error", "post_body_error", "post_body_error"])
        page.replace_html 'user_name_error', "can't be blank." if !post.user
        page.replace_html 'post_body_error', "can't be blank." if !Util.ne(post.body)
        page.replace_html 'post_error', "Sorry, something went wrong when saving your comment.<br/><br/>" if !discussion
      end
    end
  end
end