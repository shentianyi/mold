class KnifeSwitchRecordsController < ApplicationController
  before_action :set_knife_switch_record, only: [:show, :edit, :update, :destroy]

  # GET /knife_switch_records
  # GET /knife_switch_records.json
  def index
    @knife_switch_records = KnifeSwitchRecord.paginate(:page => params[:page], :per_page => 100)
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
    puts "-----------------------------"
    args = {}
    args[:mould_id] = knife_switch_record_params[:mould_id]
    args[:project_id] = knife_switch_record_params[:project_id]
    args[:switch_date] = knife_switch_record_params[:switch_date]
    args[:knife_type] = knife_switch_record_params[:knife_type]
    args[:knife_kind] = knife_switch_record_params[:knife_kind]
    args[:knife_supplier] = knife_switch_record_params[:knife_supplier]
    args[:state] = knife_switch_record_params[:state]
    args[:problem] = knife_switch_record_params[:problem]
    args[:damage_define] = knife_switch_record_params[:damage_define]
    args[:maintainman] = knife_switch_record_params[:maintainman]
    args[:qty] = knife_switch_record_params[:qty]

    args[:machine_id] = knife_switch_record_params[:machine_id]
    args[:press_num] = knife_switch_record_params[:press_num]
    args[:operater] = knife_switch_record_params[:operater]
    args[:is_ok] = knife_switch_record_params[:is_ok]
    args[:sort] = knife_switch_record_params[:sort]
    args[:outbound_id] = knife_switch_record_params[:outbound_id]

    record = KnifeSwitchRecord.where(mould_id: args[:mould_id], project_id: args[:project_id], knife_type: args[:knife_type], knife_kind: args[:knife_kind]).order(m_qty: :desc).first
    args[:m_qty] = record.nil? ? 1 : (record.m_qty.to_i + 1)

    if args[:state] == "磨损"
      args[:damage_life] = record.nil? ? (args[:press_num].to_i) : (args[:press_num].to_i - record.press_num)
      args[:broken_life] = 0
    elsif args[:state] == "断裂"
      args[:damage_life] = 0
      args[:broken_life] = record.nil? ? (args[:press_num].to_i) : (args[:press_num].to_i - record.press_num)
    else
      args[:damage_life] = 0
      args[:broken_life] = 0
    end
    args[:total_life] = args[:damage_life] | args[:broken_life]
    puts args

    @knife_switch_record = KnifeSwitchRecord.new(args)

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

  def import
    puts
    if request.post?
      puts "-----------------------------------"
      msg = Message.new
      begin
        file=params[:files][0]
        fd = FileData.new(data: file, original_name: file.original_filename, path: $upload_data_file_path, path_name: "#{Time.now.strftime('%Y%m%d%H%M%S%L')}~#{file.original_filename}")
        fd.save
        msg = FileHandler::Excel::KnifeSwitchRecordHandler.import(fd)
      rescue => e
        msg.content = e.message
      end
      render json: msg
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_knife_switch_record
      @knife_switch_record = KnifeSwitchRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def knife_switch_record_params
      params.require(:knife_switch_record).permit(:mould_id, :project_id, :switch_date, :knife_type, :knife_kind, :knife_supplier, :state, :problem, :damage_define, :maintainman, :qty, :m_qty,
                                                  :machine_id, :press_num, :damage_life, :broken_life, :total_life, :operater, :is_ok, :outbound_id, :sort, :image_id)
    end
end