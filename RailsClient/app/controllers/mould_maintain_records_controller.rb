class MouldMaintainRecordsController < ApplicationController
  before_action :set_mould_maintain_record, only: [:show, :edit, :update, :destroy]

  # GET /mould_maintain_records
  # GET /mould_maintain_records.json
  def index
    @mould_maintain_records = MouldMaintainRecord.all
  end

  # GET /mould_maintain_records/1
  # GET /mould_maintain_records/1.json
  def show
  end

  # GET /mould_maintain_records/new
  def new
    @mould_maintain_record = MouldMaintainRecord.new
  end

  # GET /mould_maintain_records/1/edit
  def edit
  end

  # POST /mould_maintain_records
  # POST /mould_maintain_records.json
  def create
    @mould_maintain_record = MouldMaintainRecord.new(mould_maintain_record_params)

    respond_to do |format|
      if @mould_maintain_record.save
        format.html { redirect_to @mould_maintain_record, notice: 'Mould maintain record was successfully created.' }
        format.json { render :show, status: :created, location: @mould_maintain_record }
      else
        format.html { render :new }
        format.json { render json: @mould_maintain_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mould_maintain_records/1
  # PATCH/PUT /mould_maintain_records/1.json
  def update
    respond_to do |format|
      if @mould_maintain_record.update(mould_maintain_record_params)
        format.html { redirect_to @mould_maintain_record, notice: 'Mould maintain record was successfully updated.' }
        format.json { render :show, status: :ok, location: @mould_maintain_record }
      else
        format.html { render :edit }
        format.json { render json: @mould_maintain_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mould_maintain_records/1
  # DELETE /mould_maintain_records/1.json
  def destroy
    @mould_maintain_record.destroy
    respond_to do |format|
      format.html { redirect_to mould_maintain_records_url, notice: 'Mould maintain record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mould_maintain_record
      @mould_maintain_record = MouldMaintainRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mould_maintain_record_params
      params.require(:mould_maintain_record).permit(:mould_id, :count, :plan_date, :real_date)
    end
end
