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

  def search
    super { |query|
      state = params[:knife_switch_record][:state]
      query = query.where("state like ?", "%#{state}%").unscope(where: :state)
    }
  end

  def get_update_params
    args = {}
    puts '-------------get_update_params-----------------'
    puts params
    if params[:action] == 'update' && params[:knife_switch_record][:mould_id].nil?
      record = KnifeSwitchRecord.find(params[:id])
      unless record.nil?
        args[:mould_id] = record.mould_id
        args[:project_id] = record.project_id
        args[:terminal_leoni_id] = record.terminal_leoni_id
        args[:switch_date] = record.switch_date
        args[:knife_type] = record.knife_type

        args[:knife_kind] = record.knife_kind
        args[:knife_supplier] = record.knife_supplier
        args[:state] = record.state
        args[:problem] = record.problem
        args[:damage_define] = record.damage_define

        args[:maintainman] = record.maintainman
        args[:qty] = record.qty
        args[:m_qty] = record.m_qty
        args[:machine_id] = record.machine_id
        args[:press_num] = params[:knife_switch_record][:press_num].nil? ? record.press_num : params[:knife_switch_record][:press_num]

        args[:damage_life] = record.damage_life
        args[:broken_life] = record.broken_life
        args[:total_life] = record.total_life
        args[:operater] = record.operater
        args[:is_ok] = record.is_ok

        args[:outbound_id] = record.outbound_id
        args[:sort] = record.sort
        args[:image_id] = record.image_id
      end
    else
      args[:mould_id] = knife_switch_record_params[:mould_id]
      args[:project_id] = knife_switch_record_params[:project_id]
      args[:terminal_leoni_id] = knife_switch_record_params[:terminal_leoni_id]
      args[:switch_date] = knife_switch_record_params[:switch_date]
      args[:knife_type] = knife_switch_record_params[:knife_type]

      args[:knife_kind] = knife_switch_record_params[:knife_kind]
      args[:knife_supplier] = knife_switch_record_params[:knife_supplier]
      args[:state] = knife_switch_record_params[:state]
      args[:problem] = knife_switch_record_params[:problem]
      args[:damage_define] = knife_switch_record_params[:damage_define]

      args[:maintainman] = knife_switch_record_params[:maintainman]
      args[:qty] = knife_switch_record_params[:qty]
      args[:m_qty] = knife_switch_record_params[:m_qty]
      args[:machine_id] = knife_switch_record_params[:machine_id]
      args[:press_num] = knife_switch_record_params[:press_num]

      args[:damage_life] = knife_switch_record_params[:damage_life]
      args[:broken_life] = knife_switch_record_params[:broken_life]
      args[:total_life] = knife_switch_record_params[:total_life]
      args[:operater] = knife_switch_record_params[:operater]
      args[:is_ok] = knife_switch_record_params[:is_ok]

      args[:outbound_id] = knife_switch_record_params[:outbound_id]
      args[:sort] = knife_switch_record_params[:sort]
      args[:image_id] = knife_switch_record_params[:image_id]
    end
    args
  end

  def reset_knife_life_before_update
    args = get_update_params
    if args.empty?
      raise "参数错误"
    end

    records = KnifeSwitchRecord.where(mould_id: args[:mould_id], project_id: args[:project_id], knife_type: args[:knife_type], knife_kind: args[:knife_kind]).where("m_qty >= #{args[:m_qty]}").order(m_qty: :asc)

    press_num_before = 0
    total_life = 0
    damage_life = 0
    broken_life = 0
    if records.first.press_num.to_i != args[:press_num].to_i
      records.each do |record|
        puts "press=#{record.press_num}----before= #{press_num_before} --------m_qty=#{record.m_qty}"
        if record.m_qty == 1
          press_num_before = args[:press_num]
          args[:damage_life] = 0
          args[:broken_life] = 0
          args[:total_life] = args[:damage_life] | args[:broken_life]
        else
          if record.m_qty.to_i == args[:m_qty].to_i
            pre_record = KnifeSwitchRecord.where(mould_id: args[:mould_id], project_id: args[:project_id], knife_type: args[:knife_type], knife_kind: args[:knife_kind], m_qty: (args[:m_qty].to_i - 1)).first
            if pre_record.nil?
              args[:damage_life] = 0
              args[:broken_life] = 0
            else
              if args[:state].include? "磨损"
                args[:damage_life] = args[:press_num].to_i - pre_record.press_num.to_i
                args[:broken_life] = 0
              elsif args[:state].include? "断裂"
                args[:damage_life] = 0
                args[:broken_life] = args[:press_num].to_i - pre_record.press_num.to_i
              end
            end
            args[:total_life] = args[:damage_life] | args[:broken_life]
            press_num_before = args[:press_num]
          elsif record.m_qty.to_i == (args[:m_qty].to_i + 1)
            puts "################press_num_before=#{press_num_before}##############record.press_num=#{record.press_num}########################################"
            if record.state.include? "磨损"
              damage_life = record.press_num.to_i - press_num_before.to_i
              broken_life = 0
            elsif record.state.include? "断裂"
              damage_life = 0
              broken_life = record.press_num.to_i - press_num_before.to_i
            end
            total_life = damage_life | broken_life
            record.update(damage_life: damage_life, broken_life: broken_life, total_life: total_life)
            press_num_before = record.press_num
          end
        end
      end
    end
    args
  end

  # PATCH/PUT /knife_switch_records/1
  # PATCH/PUT /knife_switch_records/1.json
  def update
    args = reset_knife_life_before_update
    puts '---------------------------9'
    puts args
    respond_to do |format|
      if @knife_switch_record.update(args)
        puts '---------succ--------------'
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
    params.require(:knife_switch_record).permit(:mould_id, :project_id, :terminal_leoni_id, :switch_date, :knife_type, :knife_kind, :knife_supplier, :state, :problem, :damage_define, :maintainman, :qty, :m_qty,
                                                :machine_id, :press_num, :damage_life, :broken_life, :total_life, :operater, :is_ok, :outbound_id, :sort, :image_id)
  end
end