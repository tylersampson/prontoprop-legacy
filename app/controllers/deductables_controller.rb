class DeductablesController < ApplicationController
  load_and_authorize_resource

  # GET /deductables
  def index
    @q = Deductable.all.search(params[:q])
    @deductables = @q.result.paginate(page: params[:page], per_page: params[:fetch]).decorate
  end

  # GET /deductables/1
  def show
  end

  # GET /deductables/new
  def new
  end

  # GET /deductables/1/edit
  def edit
  end

  # POST /deductables
  def create
    if @deductable.save
      redirect_to params[:commit_and_new] ? new_deductable_path : @deductable, notice: 'Deductable was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /deductables/1
  def update
    if @deductable.update(deductable_params)
      redirect_to @deductable, notice: 'Deductable was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /deductables/1
  def destroy
    @deductable.destroy
    redirect_to deductables_url, notice: 'Deductable was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deductable
      @deductable = Deductable.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def deductable_params
      params.require(:deductable).permit(:code, :name, :unit_price)
    end
end
