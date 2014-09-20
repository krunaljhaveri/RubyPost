class CommentsController < ApplicationController

  # Limit access to authorized users
  load_and_authorize_resource
  skip_authorize_resource :only => [:update, :create]

  # Get all comments
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # Show a specific comment
  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # Create a new comment
  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @comment }
    end
  end

  # Edit an existing comment
  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # Save a new comment
  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
    @comment.user = current_user

    # Limit access to authorized users
    authorize! :create, @comment

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.post, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # Update an existing comment
  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])
    @comment.user = current_user

    # Limit access to authorized users
    authorize! :update, @comment

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to @comment.post, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # Delete a specific comment
  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    post = @comment.post

    # Limit access to authorized users
    authorize! :destroy, @comment

    @comment.destroy

    respond_to do |format|
      format.html { redirect_to post, notice: 'Comment was successfully deleted.' }
      format.json { head :no_content }
    end
  end
end
