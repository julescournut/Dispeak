class AudioRecordsController < ApplicationController
  before_action :set_audio_record, only: [:show, :edit, :update, :destroy]

  # GET /audio_records
  # GET /audio_records.json
  def index
    @audio_records = AudioRecord.all
  end

  # GET /audio_records/1
  # GET /audio_records/1.json
  def show
  end

  # GET /audio_records/new
  def new
    @audio_record = AudioRecord.new
  end

  # GET /audio_records/1/edit
  def edit
  end

  # POST /audio_records
  # POST /audio_records.json
  def create
    @audio_record = AudioRecord.new(audio_record_params)

    respond_to do |format|
      if @audio_record.save
        format.html { redirect_to @audio_record, notice: 'Audio record was successfully created.' }
        format.json { render :show, status: :created, location: @audio_record }
      else
        format.html { render :new }
        format.json { render json: @audio_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /audio_records/1
  # PATCH/PUT /audio_records/1.json
  def update
    respond_to do |format|
      if @audio_record.update(audio_record_params)
        format.html { redirect_to @audio_record, notice: 'Audio record was successfully updated.' }
        format.json { render :show, status: :ok, location: @audio_record }
      else
        format.html { render :edit }
        format.json { render json: @audio_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /audio_records/1
  # DELETE /audio_records/1.json
  def destroy
    @audio_record.destroy
    respond_to do |format|
      format.html { redirect_to audio_records_url, notice: 'Audio record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_audio_record
      @audio_record = AudioRecord.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def audio_record_params
      params.require(:audio_record).permit(:b64field, :user_id)
    end
end
