class TeasController < ApplicationController
  before_action :set_tea, only: [:show, :update, :destroy]

  # GET /teas
  def index
    @teas = Tea.all

    render json: @teas
  end

  # GET /teas/1
  def show
  end

  # POST /teas
  def create
    result = NewTeaService.new.call(params.to_unsafe_h)

    case result
    in Success[:created, Tea => tea]
      render tea, status: :created
    in Failure[_, errors]
      render json: errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /teas/1
  def update
    if @tea.update(tea_params)
      render json: @tea
    else
      render json: @tea.errors, status: :unprocessable_entity
    end
  end

  # DELETE /teas/1
  def destroy
    @tea.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tea
      @tea = Tea.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tea_params
      params.require(:tea).permit(:name, :country)
    end
end
