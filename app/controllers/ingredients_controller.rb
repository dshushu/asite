class IngredientsController < ApplicationController
  
  before_action :require_user, except: [:show]
  
  def new
    @ingredient = Ingredient.new
  end
  
  def create
    @ingredient = Ingredient.new(ingredient_params)
    if @ingredient.save
      flash[:success] = @ingredient.name + " has been added"
      redirect_to root_path
    else
      render 'new'
    end
    
  end
  
  def show
    @ingredient = Ingredient.find(params[:id])
    @recipes = @ingredient.recipes.paginate(page: params[:page], per_page: 3)
  end
  
  private
  
    def ingredient_params
        params.require(:ingredient).permit(:name)
    end

end