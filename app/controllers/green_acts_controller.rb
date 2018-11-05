class GreenActsController < ApplicationController
  load_and_authorize_resource

  def new
  end

  def create
    @green_act = current_user.green_acts.build green_act_params
    if @green_act.valid?
      @green_act.save
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @green_act.update green_act_params
      flash[:success] = "Your green act is successfully updated"
      redirect_to root_url
    else
      render :edit
    end
  end

  def destroy
    if @green_act.destroy
      flash[:success] = "Your green act is successfully deleted"
    else
      flash[:error] = "There is an error while trying to delete your green act"
    end
    redirect_to root_url
  end

  private

  def green_act_params
    params.require(:green_act).permit :content, :details
  end
end
