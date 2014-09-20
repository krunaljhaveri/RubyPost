class PostsController < ApplicationController

  # Limit access to authorized users
  load_and_authorize_resource
  skip_authorize_resource :only => [:create, :update, :manage, :tags, :home]

  # Gets top 5 active posts to show on home page
  # GET /home
  def home

    # Sort posts based on scores before returning
    @posts = Post.all.sort.reverse[0..4]

    respond_to do |format|
      format.html # home.html.erb
    end
  end

  # Gets all posts
  # GET /posts
  # GET /posts.json
  def index

    # Sort posts based on scores before returning
    @posts = Post.search(params[:type], params[:query]).sort().reverse()

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # Managing posts
  # GET /posts/manage
  # GET /posts/manage.json
  def manage

    # Limit access to authorized users
    authorize! :administer, current_user

    @posts = Post.all

    respond_to do |format|
      format.html # manage.html.erb
      format.json { render json: @posts }
    end
  end

  # Display a specific post
  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # Create a new post
  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # Edit an existing post
  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # Save a new post
  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.user = current_user

    # Limit access to authorized users
    authorize! :create, @post

    if params.has_key?('hidden-post')
      @post.tags = params['hidden-post']['tags']
    else
      @post.tags = ''
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # Update an existing post
  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    @post.user = current_user

    # Limit access to authorized users
    authorize! :update, @post

    if params.has_key?('hidden-post')
      params[:post][:tags] = params['hidden-post']['tags']
    else
      params[:post][:tags] = ''
    end

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # Delete an existing post
  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      if current_user.admin? or current_user.super_admin?
        format.html { redirect_to posts_manage_url, notice: 'Post was successfully deleted.' }
      else
        format.html { redirect_to posts_url, notice: 'Post was successfully deleted.' }
      end

      format.json { head :no_content }
    end
  end

  # Fetch all tags
  # GET /tags
  def tags
    @tags = Post.tags
    @tags = @tags.map do |tag|
      {:tag => "#{tag}"}
    end
    @tags = {tags: @tags};
    respond_to do |format|
      format.html { render :json => @tags }
      format.json { render :json => @tags }
    end
  end

end
