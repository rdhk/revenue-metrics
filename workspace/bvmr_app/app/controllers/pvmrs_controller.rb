class PvmrsController < ApplicationController
  before_action :set_pvmr, only: [:show, :edit, :update, :destroy]

  # GET /pvmrs
  # GET /pvmrs.json
  def index
    @pvmrs=Pvmr.all
  end

  def drawgraph
    respond_to do |format|
      format.html
      format.json { render json: Pvmr.all.pluck('date', 'total_value').sort }
    end
  end



  def refresh
    SyncIvmrsJob.perform_now
    drawgraph
  end

  # GET /pvmrs/1
  # GET /pvmrs/1.json
  def show
  end

  # GET /pvmrs/new
  def new
    @pvmr = Pvmr.new
  end

  # GET /pvmrs/1/edit
  def edit
  end

  # POST /pvmrs
  # POST /pvmrs.json
  def create
    @pvmr = Pvmr.new(pvmr_params)

    respond_to do |format|
      if @pvmr.save
        format.html { redirect_to @pvmr, notice: 'Pvmr was successfully created.' }
        format.json { render :show, status: :created, location: @pvmr }
      else
        format.html { render :new }
        format.json { render json: @pvmr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pvmrs/1
  # PATCH/PUT /pvmrs/1.json
  def update
    respond_to do |format|
      if @pvmr.update(pvmr_params)
        format.html { redirect_to @pvmr, notice: 'Pvmr was successfully updated.' }
        format.json { render :show, status: :ok, location: @pvmr }
      else
        format.html { render :edit }
        format.json { render json: @pvmr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pvmrs/1
  # DELETE /pvmrs/1.json
  def destroy
    @pvmr.destroy
    respond_to do |format|
      format.html { redirect_to pvmrs_url, notice: 'Pvmr was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pvmr
      @pvmr = Pvmr.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pvmr_params
      params.require(:pvmr).permit(:date, :num_packages,:total_value)
    end
end
