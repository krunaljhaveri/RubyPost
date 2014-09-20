class AdminController < ApplicationController

  # Action for managing the users
  # GET /users/manage
  def manage

    # Limit access to authorized users
    authorize! :administer, current_user

    @users = User.all

    respond_to do |format|
      format.html # manage.html.erb
    end
  end

  # Action for generating the report
  # GET /report
  def report

    # Limit access to authorized users
    authorize! :administer, current_user
    @users = User.all

    @fromTime = DateTime.strptime(params[:fromTime] + ' EDT', '%m-%d-%Y %T %Z') rescue DateTime.current.beginning_of_year
    @toTime = DateTime.strptime(params[:toTime] + ' EDT', '%m-%d-%Y %T %Z') rescue DateTime.current

    params[:fromTime] = @fromTime.strftime('%m-%d-%Y %T')
    params[:toTime] = @toTime.strftime('%m-%d-%Y %T')

  end

  # Action for updating the role
  # POST /users/update-role/1
  def update_role
    @user = User.find(params[:id])

    # Limit access to authorized users
    authorize! :manage, @user

    @user.admin = params[:admin_role]
    respond_to do |format|
      if @user.save
        format.json { head :no_content }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # Action for deleting the user
  # DELETE /users/1
  def remove
    @user = User.find(params[:id])

    # Limit access to authorized users
    authorize! :destroy, @user

    removing_self = (@user.id == current_user.id)
    @user.destroy
    respond_to do |format|
      if removing_self
        format.html { redirect_to root_url }
      else
        format.html { redirect_to users_manage_url }
      end
      format.json { head :no_content }
    end
  end
end
