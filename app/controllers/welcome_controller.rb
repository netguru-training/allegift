class WelcomeController < ApplicationController

  def index
    redirect_to gifts_path unless current_user.nil?
  end

end
