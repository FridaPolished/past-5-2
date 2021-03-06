class UsersController < ApplicationController


  def new 
    @user = User.new 
  end  

  def create  
    @user = User.new(user_params)

    if @user.save
      #redirect to main page
    else  
      flash[:errors] = @user.errors.full_messages
      render :new 
    end 

  end  

  def edit
    @user = User.find(params[:id])
    render :edit
  end  

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      #redirect users user show page
    else  
      flash[:errors] = @user.errors.full_messages
      #redirect to edit page
    end 
  end  

  def show 
    @user = User.find(params[:id])
    render :show
  end 

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to new_session_url 
  end  

  private

  def user_params
    params.require(:user).permit(:username, :password, :email)
  end  

end
