class StatusesController < ApplicationController
  load_and_authorize_resource

  # GET /statuses
  def index
    @q = Status.all.search(params[:q])
    @statuses = @q.result.paginate(page: params[:page], per_page: params[:fetch]).decorate
  end

  # GET /statuses/1
  def show
  end

  # GET /statuses/new
  def new
  end

  # GET /statuses/1/edit
  def edit
  end

  # POST /statuses
  def create
    if @status.save
      redirect_to params[:commit_and_new] ? new_status_path : @status, notice: 'Status was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /statuses/1
  def update
    if @status.update(status_params)
      redirect_to @status, notice: 'Status was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /statuses/1
  def destroy
    @status.destroy
    redirect_to statuses_url, notice: 'Status was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_status
      @status = Status.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def status_params
      params.require(:status).permit(:name, :category)
    end
end
