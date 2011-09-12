class PostsController < ApplicationController
  include PostsHelper

  before_filter :store_form_data, :only => [:create]
  before_filter :authenticate_user!
  
  # GET /posts
  # GET /posts.xml
  #def index
  #  @posts = Post.all

  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.xml  { render :xml => @posts }
  #  end
  #end

  # GET /posts/1
  # GET /posts/1.xml
  #def show
  #  @post = Post.find(params[:id])

  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.xml  { render :xml => @post }
  #  end
  #end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  #def edit
  #  @post = Post.find(params[:id])
  #end

  # POST /posts
  # POST /posts.xml
  def create
    @topic = Topic.find(params[:topic_id])
    link = params[:post][:link]
    begin
        uri = URI.parse(link)
        if uri.class != URI::HTTP and uri.class != URI::HTTPS
            redirect_to(@topic, :notice => "You have some strange protocol their")
            return
        end
        rescue URI::InvalidURIError
            redirect_to(@topic, :notice => "Shit is all fucked up")
            return
    end

    @post = @topic.posts.create(params[:post])
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@topic, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  #def update
  #  @post = Post.find(params[:id])

  #  respond_to do |format|
  #    if @post.update_attributes(params[:post])
  #      format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
  #      format.xml  { head :ok }
  #    else
  #      format.html { render :action => "edit" }
  #      format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
  #    end
  #  end
  #end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  #def destroy
  #  @post = Post.find(params[:id])
  #  @post.destroy

  #  respond_to do |format|
  #    format.html { redirect_to(posts_url) }
  #    format.xml  { head :ok }
  #  end
  #end

  def vote
    @post = Post.find(params[:post_id])
  
    has_voted = did_user_vote_on_topic_post?(@post.topic_id, @post.id)

    if !has_voted 
        @votes = Vote.new

        @votes.topic_id = @post.topic_id
        @votes.user_id = current_user.id
        @votes.post_id = @post.id
        @votes.value = params[:vote]

        @votes.save
        
        respond_to do |format|
            if params[:redirect_to]
                format.html {redirect_to params[:redirect_to]}
                format.js
            else
                format.html {redirect_to topic_path(@topic)}
                format.js
            end
        end
     else
         #This should only happen when a user is not logged in. A user can
         # not view someones profile unless he has logged in.
         respond_to do |format|
            format.html {redirect_to topic_path(@topic), :notice => 'You
            already voted on the post.'}
            format.js
        end
     end


  end
end
