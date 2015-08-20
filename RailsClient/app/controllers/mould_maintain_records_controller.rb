class MouldMaintainRecordsController < ApplicationController
  before_action :set_mould_maintain_record, only: [:show, :edit, :update, :destroy]

  # GET /mould_maintain_records
  # GET /mould_maintain_records.json
  def index
    @mould_maintain_records = MouldMaintainRecord.paginate(:page => params[:page])
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
    puts "-----------------------------"
    args = {}
    args[:mould_id] = mould_maintain_record_params[:mould_id]
    args[:plan_date] = mould_maintain_record_params[:plan_date]
    args[:real_date] = mould_maintain_record_params[:plan_date]
    args[:note] = mould_maintain_record_params[:note]
    record = MouldMaintainRecord.where(mould_id: args[:mould_id]).order(count: :desc).first
    args[:count] = record.nil? ? 1 : (record.count.to_i + 1)

    @mould_maintain_record = MouldMaintainRecord.new(args)
    is_record = MouldMaintainRecord.where(mould_id: args[:mould_id], plan_date: args[:plan_date]).first

    respond_to do |format|
      if is_record.nil?
        if @mould_maintain_record.save
          format.html { redirect_to @mould_maintain_record, notice: 'Mould maintain record was successfully created.' }
          format.json { render :show, status: :created, location: @mould_maintain_record }
        else
          format.html { render :new }
          format.json { render json: @mould_maintain_record.errors, status: :unprocessable_entity }
        end
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

  def import
    puts
    if request.post?
      puts "111111111111111111111111111111"
      msg = Message.new
      begin
        file=params[:files][0]
        fd = FileData.new(data: file, original_name: file.original_filename, path: $upload_data_file_path, path_name: "#{Time.now.strftime('%Y%m%d%H%M%S%L')}~#{file.original_filename}")
        fd.save
        msg = FileHandler::Excel::MouldMaintainRecordHandler.import(fd)
      rescue => e
        msg.content = e.message
      end
      render json: msg
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mould_maintain_record
      @mould_maintain_record = MouldMaintainRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mould_maintain_record_params
      params.require(:mould_maintain_record).permit(:mould_id, :count, :plan_date, :real_date, :note)
    end
end
