class SubsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_sub, only: [:show, :edit, :update, :destroy]

  # GET /subs
  # GET /subs.json
  def index
    @subs = current_user.subs.where(archive: false)
    @archived_subs = current_user.subs.where.not(archive: false)
    @monthly_subs = monthly_subs
    @total_annual_subs = @monthly_subs * 12
  end

  # GET /subs/1
  # GET /subs/1.json
  def show
  end

  # GET /subs/new
  def new
    @sub = current_user.subs.build
  end

  # GET /subs/1/edit
  def edit
  end

  # POST /subs
  # POST /subs.json
  def create
    @sub = current_user.subs.new(sub_params)

    respond_to do |format|
      if @sub.save
        format.html { redirect_to @sub, notice: 'Sub was successfully created.' }
        format.json { render :show, status: :created, location: @sub }
      else
        format.html { render :new }
        format.json { render json: @sub.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subs/1
  # PATCH/PUT /subs/1.json
  def update
    respond_to do |format|
      if @sub.update(sub_params)
        format.html { redirect_to @sub, notice: 'Sub was successfully updated.' }
        format.json { render :show, status: :ok, location: @sub }
      else
        format.html { render :edit }
        format.json { render json: @sub.errors, status: :unprocessable_entity }
      end
    end
  end

  def archive
    @sub = Sub.find(params[:id])
  end

  # DELETE /subs/1
  # DELETE /subs/1.json
  def destroy
    @sub.destroy
    respond_to do |format|
      format.html { redirect_to subs_url, notice: 'Sub was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub
      @sub = Sub.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_params
      params.require(:sub).permit(:name, :description, :frequency, :amount, :frequency, :archive)
    end
end
