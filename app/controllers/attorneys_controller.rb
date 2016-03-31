class AttorneysController < ApplicationController
  load_and_authorize_resource

  # GET /attorneys
  def index
    @q = Attorney.all.search(params[:q])
    @attorneys = @q.result.paginate(page: params[:page], per_page: params[:fetch]).decorate
  end

  # GET /attorneys/1
  def show
  end

  # GET /attorneys/new
  def new
  end

  # GET /attorneys/1/edit
  def edit
  end

  # POST /attorneys
  def create
    if @attorney.save
      redirect_to params[:commit_and_new] ? new_attorney_path : @attorney, notice: 'Attorney was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /attorneys/1
  def update
    if @attorney.update(attorney_params)
      redirect_to @attorney, notice: 'Attorney was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /attorneys/1
  def destroy
    @attorney.destroy
    redirect_to attorneys_url, notice: 'Attorney was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attorney
      @attorney = Attorney.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def attorney_params
      params.require(:attorney).permit(:code, :name, :email, :telephone, :preferred)
    end
end
