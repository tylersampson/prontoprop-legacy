class OriginatorsController < ApplicationController
  load_and_authorize_resource

  # GET /originators
  def index
    @q = Originator.all.search(params[:q])
    @originators = @q.result.paginate(page: params[:page], per_page: params[:fetch]).decorate
  end

  # GET /originators/1
  def show
  end

  # GET /originators/new
  def new
  end

  # GET /originators/1/edit
  def edit
  end

  # POST /originators
  def create
    if @originator.save
      redirect_to params[:commit_and_new] ? new_originator_path : @originator, notice: 'Originator was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /originators/1
  def update
    if @originator.update(originator_params)
      redirect_to @originator, notice: 'Originator was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /originators/1
  def destroy
    @originator.destroy
    redirect_to originators_url, notice: 'Originator was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_originator
      @originator = Originator.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def originator_params
      params.require(:originator).permit(:code, :name, :email, :telephone, :preferred)
    end
end
