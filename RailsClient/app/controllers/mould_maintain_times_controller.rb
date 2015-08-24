class MouldMaintainTimesController < ApplicationController
  before_action :set_mould_maintain_time, only: [:show, :edit, :update, :destroy]

  # GET /mould_maintain_times
  # GET /mould_maintain_times.json
  def index
    @mould_maintain_times = MouldMaintainTime.paginate(:page => params[:page], :per_page => 100)
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
    puts "-----------------------------"
    args = {}
    args[:mould_id] = mould_maintain_time_params[:mould_id]
    args[:project_id] = mould_maintain_time_params[:project_id]
    args[:device_id] = mould_maintain_time_params[:device_id]
    args[:serviceman] = mould_maintain_time_params[:serviceman]
    args[:maintain_date] = mould_maintain_time_params[:maintain_date]
    args[:err_note] = mould_maintain_time_params[:err_note]
    args[:solution_method] = mould_maintain_time_params[:solution_method]
    args[:code] = mould_maintain_time_params[:code]
    args[:feed_code] = mould_maintain_time_params[:feed_code]
    args[:start_time] = mould_maintain_time_params[:start_time]
    args[:end_time] = mould_maintain_time_params[:end_time]
    unless args[:end_time].empty? && args[:start_time].empty?
      args[:downtime] = (args[:end_time].to_s.to_time - args[:start_time].to_s.to_time) / 60
    end
    puts args
    @mould_maintain_time = MouldMaintainTime.new(args)

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

  def import
    puts
    if request.post?
      puts "-----------------------------------"
      msg = Message.new
      begin
        file=params[:files][0]
        fd = FileData.new(data: file, original_name: file.original_filename, path: $upload_data_file_path, path_name: "#{Time.now.strftime('%Y%m%d%H%M%S%L')}~#{file.original_filename}")
        fd.save
        msg = FileHandler::Excel::MouldMaintainTimeHandler.import(fd)
      rescue => e
        msg.content = e.message
      end
      render json: msg
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_mould_maintain_time
    @mould_maintain_time = MouldMaintainTime.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def mould_maintain_time_params
    params.require(:mould_maintain_time).permit(:mould_id, :project_id, :device_id, :serviceman, :err_note, :solution_method, :code, :feed_code, :start_time, :end_time, :downtime, :maintain_date)
  end
end
