class FoodsController < ApplicationController
  def index
    @foodlists = Food.all
  end

  def show
    @foodlist = Food.find(params[:id])
  end

  def destroy
    foodlist = Food.find(params[:id])

    if foodlist.destroy
      flash[:success] = 'foodList deleted successfully'
      redirect_to foodlists_path
    else
      flash.now[:error] = 'Error: foodList could not be deleted'
      @foods = Food.all
    end

    def new
      @food = Food.new
    end

    def create
      @food = Food.new(params.require(:food).permit(:name, :measurement_unit, :price, :quantity))
      @food.user = current_user

      if @food.save
        flash[:success] = 'Ingredient saved successfully'
        redirect_to foods_path(current_user)
      else
        flash.now[:error] = 'Error: Ingredient could not be saved'
      end
    end

    def destroy
      food = Food.find(params[:id])
      food.destroy

      if food.destroy
        flash[:success] = 'Food deleted successfully'
        redirect_to foods_path
      else
        flash.now[:error] = 'Error: Recipe could not be deleted'
      end
    end
  end
end
