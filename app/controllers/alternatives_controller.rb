class AlternativesController < ApplicationController
  before_action :set_alternative, only: [:show, :edit, :update, :destroy]
  
  # GET /alternatives
  # GET /alternatives.json
  def index
    session[:showable] = "alternatives"
    session[:exampleable_type] = "basic"
    @alternatives = current_user.own_alternatives
    @user = current_user
  end

  # GET /alternatives/1
  # GET /alternatives/1.json
  def show
  end

  # GET /alternatives/new
  def new
    @alternative = Alternative.new
  end

  # GET /alternatives/1/edit
  def edit
  end

  # POST /alternatives
  # POST /alternatives.json
  def create
    @alternative = Alternative.new(alternative_params)
    @alternative.user = User.find(params[:user_id])
    @alternative.proposer = current_user

    respond_to do |format|
      if @alternative.save
        
        #Create notification
        if @alternative.user != current_user
          Notification.create(recipient: @alternative.user, actor: current_user, 
                              notifiable: @alternative, action: "proposed")
        end
        
        format.js
        format.html { render alternatives_path }
      else
        format.json { render json: @alternative.errors, status: :unprocessable_entity }
        format.html { redirect_to alternatives_path, flash[:danger] = @alternative.errors }
      end
    end
  end

  # PATCH/PUT /alternatives/1
  # PATCH/PUT /alternatives/1.json
  def update
    respond_to do |format|
      if @alternative.update(alternative_params)
        format.html { redirect_to @alternative, notice: 'Alternative was successfully updated.' }
        format.json { render :show, status: :ok, location: @alternative }
      else
        format.html { render :edit }
        format.json { render json: @alternative.errors, status: :unprocessable_entity }
      end
    end
  end

  
  # DELETE /alternatives/1
  # DELETE /alternatives/1.json
  def destroy
    @alternative.destroy
    respond_to do |format|
      format.html { redirect_to alternatives_url, notice: 'Alternative was successfully deleted.' }
      format.js
    end
  end
  
  def destroy_proposal
    @alternative = Alternative.find(params[:id])
    @user = @alternative.user
    @alternative.destroy
    respond_to do |format|
      format.html { redirect_to propose_alternatives_path(@user.id), notice: 'Proposal was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alternative
      @alternative = Alternative.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alternative_params
      params.require(:alternative).permit(:name, :proposer_id, :user_id)
    end
end
