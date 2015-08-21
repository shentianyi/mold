class KnifeSwitchSlicesController < ApplicationController
  before_action :set_knife_switch_slice, only: [:show, :edit, :update, :destroy]

  # GET /knife_switch_slices
  # GET /knife_switch_slices.json
  def index
    @knife_switch_slices = KnifeSwitchSlice.paginate(:page => params[:page], :per_page => 15)
  end

  # GET /knife_switch_slices/1
  # GET /knife_switch_slices/1.json
  def show
  end

  # GET /knife_switch_slices/new
  def new
    @knife_switch_slice = KnifeSwitchSlice.new
  end

  # GET /knife_switch_slices/1/edit
  def edit
  end

  def do_image_param params
    args = {}
    after_image_path = ''
    before_image_path = ''

    unless params[:image_before].nil?
      before_image_path = $image_path + Time.now.strftime('%Y-%m-%d_%H_%M_%S_%s')+ "-before-" + params[:image_before].original_filename
      File.open(before_image_path, 'wb') do |f|
        f.write(params[:image_before].read)
      end
    end

    unless params[:image_after].nil?
      after_image_path = $image_path + Time.now.strftime('%Y-%m-%d_%H_%M_%S_%s') + "-after-" + params[:image_after].original_filename

      File.open(after_image_path, 'wb') do |f|
        f.write(params[:image_after].read)
      end
    end

    args[:mould_id] = params[:mould_id]
    args[:project_id] = params[:project_id]
    args[:terminal_leoni_id] = params[:terminal_leoni_id]
    args[:switch_date] = params[:switch_date]
    args[:knife_type1] = params[:knife_type1]
    args[:knife_type2] = params[:knife_type2]
    args[:wire_type] = params[:wire_type]
    args[:wire_cross] = params[:wire_cross]
    args[:image_after] = after_image_path
    args[:image_before] = before_image_path
    args[:is_ok] = params[:is_ok]

    args
  end

  # POST /knife_switch_slices
  # POST /knife_switch_slices.json
  def create
    puts "---------------------------------"
    args = do_image_param(knife_switch_slice_params)
    puts args
    @knife_switch_slice = KnifeSwitchSlice.new(args)

    respond_to do |format|
      if @knife_switch_slice.save
        format.html { redirect_to @knife_switch_slice, notice: 'Knife switch slice was successfully created.' }
        format.json { render :show, status: :created, location: @knife_switch_slice }
      else
        format.html { render :new }
        format.json { render json: @knife_switch_slice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /knife_switch_slices/1
  # PATCH/PUT /knife_switch_slices/1.json
  def update
    respond_to do |format|
      if @knife_switch_slice.update(do_image_param(knife_switch_slice_params))
        format.html { redirect_to @knife_switch_slice, notice: 'Knife switch slice was successfully updated.' }
        format.json { render :show, status: :ok, location: @knife_switch_slice }
      else
        format.html { render :edit }
        format.json { render json: @knife_switch_slice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /knife_switch_slices/1
  # DELETE /knife_switch_slices/1.json
  def destroy
    @knife_switch_slice.destroy
    respond_to do |format|
      format.html { redirect_to knife_switch_slices_url, notice: 'Knife switch slice was successfully destroyed.' }
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
        msg = FileHandler::Excel::KnifeSwitchSliceHandler.import(fd)
      rescue => e
        msg.content = e.message
      end
      render json: msg
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_knife_switch_slice
    @knife_switch_slice = KnifeSwitchSlice.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def knife_switch_slice_params
    params.require(:knife_switch_slice).permit(:mould_id, :project_id, :terminal_leoni_id, :knife_type1, :knife_type2, :wire_type, :image_after, :image_before, :switch_date,
                                               :is_ok, :wire_cross)
  end
end