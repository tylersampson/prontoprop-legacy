class PropertiesController < ApplicationController
  load_and_authorize_resource

  # GET /properties
  def index
    @q = Property.all.joins(:owner, :address).select('properties.*, contacts.name as owner_name, addresses.suburb as suburb, addresses.city as city').search(params[:q])
    @properties = @q.result.paginate(page: params[:page], per_page: params[:fetch]).decorate
  end

  # GET /properties/1
  def show
  end

  # GET /properties/new
  def new
    @property.build_owner
    @property.build_address
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  def create
    if @property.save
      redirect_to params[:commit_and_new] ? new_property_path : @property, notice: 'Property was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /properties/1
  def update
    if @property.update(property_params)
      redirect_to @property, notice: 'Property was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /properties/1
  def destroy
    @property.destroy
    redirect_to properties_url, notice: 'Property was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def property_params
      params.require(:property).permit(:code, :name, :owner_id, :listing_type, :external_id, :owner_attributes => [:id, :name, :email, :telephone, :mobile], :agent_properties_attributes => [:id, :agent_id, :commission_percent, :_destroy], :address_attributes => [:id, :unit, :complex, :street_no, :street_name, :crossing_street, :suburb, :city, :country, :code])
    end
end
