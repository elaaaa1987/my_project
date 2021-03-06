class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all.order("created_at DESC").includes(:attachments,:role)
    @roles = Role.where(:status => false)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @roles = Role.all.where(:status => false)
  end

  # GET /users/1/edit
  def edit
    @roles = Role.all.where(:status => false)
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)    
    respond_to do |format|
      if @user.save
        if params["user"]["attachments_attributes"]
          params["user"]["attachments_attributes"]["attachments"].each do |file|
            @user.attachments.create(:attachment => file)
          end
        end

        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        @roles = Role.all.where(:status => false)
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        @roles = Role.all.where(:status => false)
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def show_users
    unless params["role"]
      @users = User.all.where(:role_id => nil).order("created_at DESC")
    else
      @users = User.all.where(:role_id => params["role"]).order("created_at DESC")
    end
      render :partial => "/users/users_list", :locals => { :users => @users }

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :role_id, :attachments_attributes => [:attachments])
    end
end
