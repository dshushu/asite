class RecipesController < ApplicationController

  before_action :set_recipe, only: [:show, :edit, :update, :like, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :require_recipe_owner, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]
  
  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 3)
  end
  
  def show
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_user
    
    if @recipe.save
      flash[:success] = "Recipe created"
      redirect_to recipes_path
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Recipe updated successfully"
      redirect_to recipe_path(@recipe)
    else
      render :edit
    end
  end
  
  def like
    like = Like.create(like: params[:like], chef: current_user, recipe: @recipe)
    if like.valid?
      flash[:success] = "Your selection was successful"
    else
      flash[:warning] = "Can only like/dislike recipe once"
    end
    redirect_to :back
  end
  
  def destroy
    @recipe.destroy
    flash[:success] = "Recipe deleted"
    redirect_to root_path
  end
  
  private
  
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture, style_ids: [], ingredient_ids: [])
    end
    
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def require_recipe_owner
      if !current_user.admin && @recipe.chef != current_user
        flash[:danger] = 'Can only edit your own recipe'
        redirect_to recipes_path
      end
    end
    
end