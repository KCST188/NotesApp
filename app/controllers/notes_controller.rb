class NotesController < ApplicationController
  before_action :set_note, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :correct_user, only: %i[edit update destroy]
  include NotesHelper

  # GET /notes or /notes.json
  def index
    @notes = Note.all
  end

  # GET /notes/1 or /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = current_user.notes.build
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes or /notes.json
  def create
    @note = current_user.notes.build(note_params)
    set_temp
    unless @note.temperature.nil?
      respond_to do |format|
        if @note.save
          format.html { redirect_to notes_path, notice: "Note was successfully created." }
          format.json { render :show, status: :created, location: @note }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @note.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /notes/1 or /notes/1.json
  def update
    set_temp
    unless @note.temperature.nil?
      respond_to do |format|
          if @note.update(note_params)
            format.html { redirect_to @note, notice: "Note was successfully updated." }
            format.json { render :show, status: :ok, location: @note }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @note.errors, status: :unprocessable_entity }
          end
        end
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_url, notice: "Note was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @note = current_user.notes.find_by(id: params[:id])
    redirect_to notes_path, notice: "Not autorized to edit this list" if @note.nil?
  end

  private

  def set_temp
    begin
    json = (Rails.configuration.open_weather_api.current city: @note.city).to_json
    parse = ActiveSupport::JSON.decode(json)
    x = parse['main']['temp'] - 273.15
    @note.temperature = x.round.to_s + "℃"
    rescue
      redirect_to notes_path alert:"Invalid city"
    end
  end

    # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find(params[:id])
  end

    # Only allow a list of trusted parameters through.
  def note_params
    params.require(:note).permit(:city, :note, :user_id, :note_date)
  end
end
