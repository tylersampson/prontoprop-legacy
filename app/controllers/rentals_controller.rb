class RentalsController < ApplicationController
  load_and_authorize_resource

  # GET /rentals
  def index
    @q = Rental.all.search(params[:q])
    @rentals = @q.result.paginate(page: params[:page], per_page: params[:fetch]).decorate
  end

  # GET /rentals/1
  def show
  end

  # GET /rentals/new
  def new
  end

  # GET /rentals/1/edit
  def edit
  end

  # POST /rentals
  def create
    if @rental.save
      redirect_to params[:commit_and_new] ? new_rental_path : @rental, notice: 'Rental was successfully created.'
    else
      render :new
    end
  end
  
  def import
    complete,total = Rental.import(params[:file])
    redirect_to rentals_path, notice: "#{complete} / #{total} rentals were successfully imported"
  end

  # PATCH/PUT /rentals/1
  def update
    if @rental.update(rental_params)
      redirect_to @rental, notice: 'Rental was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /rentals/1
  def destroy
    @rental.destroy
    redirect_to rentals_url, notice: 'Rental was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rental
      @rental = Rental.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def rental_params
      params.require(:rental).permit(:lease_id, :date_received, :amount_received, :commission, :vat)
    end
end
