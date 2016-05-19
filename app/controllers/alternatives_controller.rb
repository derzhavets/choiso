class AlternativesController < ApplicationController
  before_action :set_alternative, only: [:show, :edit, :update, :destroy]

  # GET /alternatives
  # GET /alternatives.json
  def index
    @alternatives = current_user.alternatives.where(proposer_id: current_user.id)
    @alternative = Alternative.new
  
    @proposals = current_user.alternatives.where(user_id: current_user.id)
    
    @proposers = Array.new
    @proposals.each do |prop|
      usr = User.find(prop.proposer.id)
      @proposers << usr
    end
    
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
    @alternative.user_id = current_user.id
    @alternative.proposed_by = current_user.id

    respond_to do |format|
      if @alternative.save
        format.html { redirect_to alternatives_path, notice: 'Alternative was successfully added.' }
        format.json { render :show, status: :created, location: @alternative }
      else
        format.html { render :new }
        format.json { render json: @alternative.errors, status: :unprocessable_entity }
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
  
  def propose
    @alternative = Alternative.new
    @proposant = User.find(params[:id])
  end
  
  def add_proposal
    @alternative = Alternative.new(alternative_params)
    @alternative.proposer_id = current_user.id
    
    if @alternative.save
      redirect_to propose_alternatives_path(alternative_params[:user_id]), notice: "Alternative was successfully proposed."
    else
      redirect_to propose_alternatives_path(alternative_params[:user_id]), flash[:error] = "There was an error with adding proposal. Fuck knows why. :("
    end
  end
  
  # DELETE /alternatives/1
  # DELETE /alternatives/1.json
  def destroy
    @alternative.destroy
    respond_to do |format|
      format.html { redirect_to alternatives_url, notice: 'Alternative was successfully deleted.' }
      format.json { head :no_content }
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
      params.require(:alternative).permit(:name, :proposed_by, :user_id)
    end
end
