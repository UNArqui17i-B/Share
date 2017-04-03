class BlinkboxFilesController < ApplicationController
  before_action :set_blinkbox_file, only: [:show, :update, :destroy, :share, :update_name, :update_expiring_date]

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

  def share
    emails_to_add = params[:add]
    emails_to_remove = params[:remove]

    shared = @blinkbox_file.shared.to_set

    emails_to_remove.each do |email|
      @blinkbox_file.shared.delete(email)
    end

    emails_to_add.each do |email|
      @blinkbox_file.shared << email unless shared.include?(email)
    end

    if @blinkbox_file.save
      json_response = {
        "_id": @blinkbox_file._id,
        "_rev": @blinkbox_file._rev
      }
      render json: json_response
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

  def update_expiring_date
    uploaded_date = @blinkbox_file.uploaded_date
    new_exp_date = params[:date].to_f
    limit = uploaded_date + 7.days.to_i
    current_date = Time.now.to_i

    if current_date <= new_exp_date && new_exp_date <= limit
      @blinkbox_file.expiring_date = new_exp_date
      if @blinkbox_file.save
        render json: @blinkbox_file
      else
        render json: @blinkbox_file.errors, status: :unprocessable_entity
      end
    else
      render json: @blinkbox_file.errors, status: :not_acceptable
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
