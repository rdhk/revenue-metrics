class IvmrsController < ApplicationController
  before_action :set_ivmr, only: [:show, :edit, :update, :destroy]

  # GET /ivmrs
  # GET /ivmrs.json

  def test
    # authenticate
    # Resque.enqueue(IvmrSnapshot)
    # SyncIvmrsJob.perform_later
    drawgraph
  end

  def drawgraph
    respond_to do |format|
      format.html
      # format.json { render({ json: Ivmr.all.pluck('api_time', 'ivmr_value').sort }) }
      format.json { render({ json: Ivmr.all.select('api_time', 'ivmr_value').order("api_time ASC").map(&:attributes).map(&:values).map(&:reverse).map(&:compact) }) }
    end
  end

  def drawgraph_bvmr
    respond_to do |format|
      format.html
      # format.json { render({ json: Ivmr.all.pluck('api_time', 'ivmr_value').sort }) }
      format.json { render({ json: Bvmr.all.select('api_time', 'bvmr_value').order("api_time ASC").map(&:attributes).map(&:values).map(&:reverse).map(&:compact) }) }
    end
  end



  # class Format
  #   def initialize
  #     @default_block = render template, layout: true
  #   end
  #   def html(*block)
  #     @html_block = block
  #   end
  #   def json(*block)
  #     @json_block = block
  #   end
  #   def execute
  #     @html_block.call if @requested = "application/html"
  #     @json_block.call if @requested = "application/json"
  #   end
  # end
  
  # format = Format.new
  # format.requested = request.accept_header
  # call_action(format)
  # format.execute


  def index
    @ivmrs = Ivmr.all
  end

  # GET /ivmrs/1
  # GET /ivmrs/1.json
  def show
  end

  # GET /ivmrs/new
  def new
    @ivmr = Ivmr.new
  end

  # GET /ivmrs/1/edit
  def edit
  end

  # POST /ivmrs
  # POST /ivmrs.json
  def create
    @ivmr = Ivmr.new(ivmr_params)

    respond_to do |format|
      if @ivmr.save
        format.html { redirect_to @ivmr, notice: 'Ivmr was successfully created.' }
        format.json { render :show, status: :created, location: @ivmr }
      else
        format.html { render :new }
        format.json { render json: @ivmr.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ivmrs/1
  # PATCH/PUT /ivmrs/1.json
  def update
    respond_to do |format|
      if @ivmr.update(ivmr_params)
        format.html { redirect_to @ivmr, notice: 'Ivmr was successfully updated.' }
        format.json { render :show, status: :ok, location: @ivmr }
      else
        format.html { render :edit }
        format.json { render json: @ivmr.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ivmrs/1
  # DELETE /ivmrs/1.json
  def destroy
    @ivmr.destroy
    respond_to do |format|
      format.html { redirect_to ivmrs_url, notice: 'Ivmr was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username,password|
      username == "furlenco" && password == "test"
  end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ivmr
      byebug
      @ivmr = Ivmr.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ivmr_params
      params.require(:ivmr).permit(:ivmr_value, :api_time)
    end
end



  