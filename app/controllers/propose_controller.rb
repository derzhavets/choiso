class ProposeController < ApplicationController
  
  def new_alternatives
    @alternative = Alternative.new
    @propose_for = User.find(params[:id])
  end
end