class ImagesController < ApplicationController
  #before_action :set_image, only: [:show, :edit, :update, :destroy]
  #before_filter :find_image_by_param, :only => [:show]


  #处理文件的上传
  def upload
    @image=Image.attach_files(params[:imgFile], params[:imgTitle])
    if @image
      render :text => {"error" => 0, "url" => "#{url_for :controller => "image", :action => "show", :id => @image}"}.to_json
    else
      render :text => {"error" => 1}
    end
  end

  #显示所有上传的图片
  def show_image_list
    @images = Image.find(:all)
    @json=[]
    @images.each do |image|
      temp= %Q/{
            "filesize" : "#{image.filesize}",
            "filename" : "#{image.filename}",
            "dir_path" : "#{url_for :controller => "image", :action => "show", :id => image}.#{image.filename_suffix}",
            "datetime" : "#{image.created_on.strftime("%Y-%m-%d %H:%M")}"
      }/
      @json << temp
    end
    render :text => ("{\"file_list\":[" << @json.join(", ") << "]}")
  end

  # GET /images
  # GET /images.json
  def index
    @images = Image.all
  end

  # GET /images/1
  # GET /images/1.json
  def show
    #data=File.new(params[:image], "rb").read

    puts '----------------------'
    #puts data
    send_file(params[:image])
  end

  # GET /images/new
  def new
    @image = Image.new
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    puts '----------------------'
    puts "#{params[:image][:filename]}"
    File.open('/home/lzd/图片/test.jpg', 'wb') do |f|
      f.write(params[:image][:filename].read)
    end

    raise

    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_image
    @image = Image.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_params
    params[:image].permit(:image, :filename)
  end

  def find_image_by_param
    @image=Image.find(params[:id]) if params[:id]
  end

end
