class LoginsController < ApplicationController
  
  def new
    
  end
  
  def create
    chef = Chef.find_by(email: params[:email])
    if chef && chef.authenticate(params[:password])
      session[:chef_id] = chef.id
      # flash[:success] = "Welcome, " + chef.chefname
      redirect_to recipes_path
    else
      flash.now[:danger] = 'Login incorrect'
      render 'new'
    end
  end
  
  def destroy
    session[:chef_id] = nil
    flash[:info] = 'Goodbye'
    redirect_to root_path
  end

end