class KnifeSwitchRecordsController < ApplicationController
  before_action :set_knife_switch_record, only: [:show, :edit, :update, :destroy]

  # GET /knife_switch_records
  # GET /knife_switch_records.json
  def index
    @knife_switch_records = KnifeSwitchRecord.all
  end

  # GET /knife_switch_records/1
  # GET /knife_switch_records/1.json
  def show
  end

  # GET /knife_switch_records/new
  def new
    @knife_switch_record = KnifeSwitchRecord.new
  end

  # GET /knife_switch_records/1/edit
  def edit
  end

  # POST /knife_switch_records
  # POST /knife_switch_records.json
  def create
    @knife_switch_record = KnifeSwitchRecord.new(knife_switch_record_params)

    respond_to do |format|
      if @knife_switch_record.save
        format.html { redirect_to @knife_switch_record, notice: 'Knife switch record was successfully created.' }
        format.json { render :show, status: :created, location: @knife_switch_record }
      else
        format.html { render :new }
        format.json { render json: @knife_switch_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /knife_switch_records/1
  # PATCH/PUT /knife_switch_records/1.json
  def update
    respond_to do |format|
      if @knife_switch_record.update(knife_switch_record_params)
        format.html { redirect_to @knife_switch_record, notice: 'Knife switch record was successfully updated.' }
        format.json { render :show, status: :ok, location: @knife_switch_record }
      else
        format.html { render :edit }
        format.json { render json: @knife_switch_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /knife_switch_records/1
  # DELETE /knife_switch_records/1.json
  def destroy
    @knife_switch_record.destroy
    respond_to do |format|
      format.html { redirect_to knife_switch_records_url, notice: 'Knife switch record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_knife_switch_record
      @knife_switch_record = KnifeSwitchRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def knife_switch_record_params
      params.require(:knife_switch_record).permit(:mould_id, :project_id, :knife_type, :knife_kind, :knife_supplier, :state, :problem, :damage_define, :maintainman, :m_qty, :machine_id, :press_num, :damage_life, :broken_life, :total_life)
    end
end
