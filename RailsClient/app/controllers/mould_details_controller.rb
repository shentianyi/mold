class MouldDetailsController < ApplicationController
  before_action :set_mould_detail, only: [:show, :edit, :update, :destroy]

  # GET /mould_details
  # GET /mould_details.json
  def index
    @mould_details = MouldDetail.all
  end

  # GET /mould_details/1
  # GET /mould_details/1.json
  def show
  end

  # GET /mould_details/new
  def new
    @mould_detail = MouldDetail.new
  end

  # GET /mould_details/1/edit
  def edit
  end

  def import
    if request.post?
      puts "---------------------------"
      msg = Message.new
      begin
        file=params[:files][0]
        fd = FileData.new(data: file, original_name: file.original_filename, path: $upload_data_file_path, path_name: "#{Time.now.strftime('%Y%m%d%H%M%S%L')}~#{file.original_filename}")
        fd.save
        file=FileHandler::Csv::File.new(user_agent: request.user_agent.downcase, file_path: fd.full_path, file_name: file.original_filename)
        msg = FileHandler::Csv::MouldDetailHandler.import(file)
      rescue => e
        msg.content = e.message
      end
      render json: msg
    end
  end

  # POST /mould_details
  # POST /mould_details.json
  def create
    @mould_detail = MouldDetail.new(mould_detail_params)

    respond_to do |format|
      if @mould_detail.save
        format.html { redirect_to @mould_detail, notice: 'Mould detail was successfully created.' }
        format.json { render :show, status: :created, location: @mould_detail }
      else
        format.html { render :new }
        format.json { render json: @mould_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mould_details/1
  # PATCH/PUT /mould_details/1.json
  def update
    respond_to do |format|
      if @mould_detail.update(mould_detail_params)
        format.html { redirect_to @mould_detail, notice: 'Mould detail was successfully updated.' }
        format.json { render :show, status: :ok, location: @mould_detail }
      else
        format.html { render :edit }
        format.json { render json: @mould_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mould_details/1
  # DELETE /mould_details/1.json
  def destroy
    @mould_detail.destroy
    respond_to do |format|
      format.html { redirect_to mould_details_url, notice: 'Mould detail was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_mould_detail
    @mould_detail = MouldDetail.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def mould_detail_params
    params.require(:mould_detail).permit(:mould_id, :mould_type, :mould_supplier, :position, :terminal_leoni_no, :terminal_supplier, :stopwater, :use_range, :wire_type, :wire_cross,
                                         :original_param_ch, :original_param_cw, :actual_param_ch, :actual_param_cw, :actual_param_ich, :actual_param_icw, :step_dch_id, :step_ich_id,
                                         :next_time, :c_up_knife, :i_up_knife, :c_down_knife, :i_down_knife, :upper_punch, :coc, :coh, :feeding_claw, :after_groove, :before_groove,
                                         :oil_cup, :buy_time, :release_report, :fixed_asset_id, :idle_time)
  end
end