class LeasesController < ApplicationController
  load_and_authorize_resource :property
  load_and_authorize_resource through: :property

  # GET /leases
  def index
    @q = @property.leases.search(params[:q])
    @leases = @q.result.paginate(page: params[:page], per_page: params[:fetch]).decorate
  end

  # GET /leases/1
  def show
  end

  # GET /leases/new
  def new
  end

  # GET /leases/1/edit
  def edit
  end

  # POST /leases
  def create
    if @lease.save
      redirect_to params[:commit_and_new] ? new_property_lease_path(@property) : property_lease_path(@property, @lease), notice: 'Lease was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /leases/1
  def update
    if @lease.update(lease_params)
      redirect_to property_lease_path(@property, @lease), notice: 'Lease was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /leases/1
  def destroy
    @lease.destroy
    redirect_to property_leases_url(@property), notice: 'Lease was successfully destroyed.'
  end

  private
        

    # Only allow a trusted parameter "white list" through.
    def lease_params
      params.require(:lease).permit(:code, :property_id, :lessor_id, :managed, :start_on, :end_on, :actual_end_on, :rent_amount, :deposit_amount, :deposit_held_by, :lease_fee, :inspection_fee, :credit_check_fee, :credit_check_fee_paid_on, :deposit_released_on, :deposit_released_to, :status_id)
    end
end
