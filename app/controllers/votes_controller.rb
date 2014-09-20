class VotesController < ApplicationController

  # Limit access to authorized users
  load_and_authorize_resource
  skip_authorize_resource :only => :create

  # Get all votes
  # GET /votes
  # GET /votes.json
  def index
    redirect_to root_url
  end

  # Show a specific vote
  # GET /votes/1
  # GET /votes/1.json
  def show
    redirect_to root_url
  end

  # Create a new vote
  # GET /votes/new
  # GET /votes/new.json
  def new
    redirect_to root_url
  end

  # Edit an existing vote
  # GET /votes/1/edit
  def edit
    redirect_to root_url
  end

  # Save a new vote
  # POST /votes
  # POST /votes.json
  def create
    @vote = Vote.new(:voteable_id => params[:voteable_id], :voteable_type => params[:voteable_type], :user => User.find(params[:user_id]))
    authorize! :create, @vote

    respond_to do |format|
      if @vote.save
        format.html { redirect_to @vote, notice: 'Vote was successfully created.' }
        format.json { render json: @vote, status: :created, location: @vote }
      else
        format.html { render action: "new" }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # Update an existing vote
  # PUT /votes/1
  # PUT /votes/1.json
  def update
    @vote = Vote.find(params[:id])

    respond_to do |format|
      if @vote.update_attributes(params[:vote])
        format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # Delete an existing vote
  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy

    respond_to do |format|
      format.html { redirect_to votes_url }
      format.json { head :no_content }
    end
  end
end
