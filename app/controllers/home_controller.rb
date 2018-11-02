class HomeController < ApplicationController
  def index
    @green_acts = GreenAct.includes(:user).order created_at: :desc
  end
end
