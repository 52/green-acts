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

  private

  def green_act_params
    params.require(:green_act).permit :content, :details
  end
end
