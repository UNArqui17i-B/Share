class BlinkboxFilesController < ApplicationController
  before_action :set_blinkbox_file, only: [:show, :update, :destroy, :update_name]

  # GET /blinkbox_files
  def index
    @blinkbox_files = BlinkboxFile.all

    render json: @blinkbox_files
  end

  # GET /blinkbox_files/1
  def show
    render json: @blinkbox_file
  end

  # POST /blinkbox_files
  def create
    @blinkbox_file = BlinkboxFile.new(blinkbox_file_params)

    if @blinkbox_file.save
      render json: @blinkbox_file, status: :created, location: @blinkbox_file
    else
      render json: @blinkbox_file.errors, status: :unprocessable_entity
    end
  end

  def update_name
    @blinkbox_file.name = params[:name]
    if @blinkbox_file.save
      render json: @blinkbox_file
    else
      render json: @blinkbox_file.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /blinkbox_files/1
  def update
    if @blinkbox_file.update(blinkbox_file_params)
      render json: @blinkbox_file
    else
      render json: @blinkbox_file.errors, status: :unprocessable_entity
    end
  end

  # DELETE /blinkbox_files/1
  def destroy
    @blinkbox_file.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blinkbox_file
      @blinkbox_file = BlinkboxFile.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def blinkbox_file_params
      params.require(:blinkbox_file).permit(:name, :extension, :size, :uploaded_date, :expiring_date, :owner)
    end
end
