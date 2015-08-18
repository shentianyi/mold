class MouldMaintainTimesController < ApplicationController
  before_action :set_mould_maintain_time, only: [:show, :edit, :update, :destroy]

  # GET /mould_maintain_times
  # GET /mould_maintain_times.json
  def index
    @mould_maintain_times = MouldMaintainTime.all
  end

  # GET /mould_maintain_times/1
  # GET /mould_maintain_times/1.json
  def show
  end

  # GET /mould_maintain_times/new
  def new
    @mould_maintain_time = MouldMaintainTime.new
  end

  # GET /mould_maintain_times/1/edit
  def edit
  end

  # POST /mould_maintain_times
  # POST /mould_maintain_times.json
  def create
    @mould_maintain_time = MouldMaintainTime.new(mould_maintain_time_params)

    respond_to do |format|
      if @mould_maintain_time.save
        format.html { redirect_to @mould_maintain_time, notice: 'Mould maintain time was successfully created.' }
        format.json { render :show, status: :created, location: @mould_maintain_time }
      else
        format.html { render :new }
        format.json { render json: @mould_maintain_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mould_maintain_times/1
  # PATCH/PUT /mould_maintain_times/1.json
  def update
    respond_to do |format|
      if @mould_maintain_time.update(mould_maintain_time_params)
        format.html { redirect_to @mould_maintain_time, notice: 'Mould maintain time was successfully updated.' }
        format.json { render :show, status: :ok, location: @mould_maintain_time }
      else
        format.html { render :edit }
        format.json { render json: @mould_maintain_time.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mould_maintain_times/1
  # DELETE /mould_maintain_times/1.json
  def destroy
    @mould_maintain_time.destroy
    respond_to do |format|
      format.html { redirect_to mould_maintain_times_url, notice: 'Mould maintain time was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mould_maintain_time
      @mould_maintain_time = MouldMaintainTime.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mould_maintain_time_params
      params.require(:mould_maintain_time).permit(:mould_id, :project_id, :device_id, :serviceman, :err_note, :solution_method, :code, :feed_code)
    end
end
