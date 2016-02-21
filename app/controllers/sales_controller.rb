class SalesController < ApplicationController
  load_and_authorize_resource

  # GET /sales
  def index
    @q = Sale.all.joins(:property, :status).joins('LEFT JOIN contacts ON contacts.id = sales.buyer_id').select('sales.*, properties.name as property_name, contacts.name as buyer_name, statuses.name as status_name').search(params[:q])
    @sales = @q.result.paginate(page: params[:page], per_page: params[:fetch]).decorate
  end

  # GET /sales/1
  def show
  end

  # GET /sales/new
  def new   
    if params[:property_id].blank?
      redirect_to properties_path, alert: 'Please create sale from property menu'
    else
      @property = Property.find(params[:property_id])
      @sale.property = @property
      @property.agent_properties.each do |ap|        
        @sale.commissions.build(
          agent_id: ap.agent_id,
          commission_percent: ap.commission_percent,          
          tax_percent: ap.agent.tax
        )
      end
    end
  end

  # GET /sales/1/edit
  def edit
  end

  # POST /sales
  def create
    if @sale.save
      redirect_to params[:commit_and_new] ? new_sale_path : @sale, notice: 'Sale was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /sales/1
  def update
    if @sale.update(sale_params)
      redirect_to @sale, notice: 'Sale was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /sales/1
  def destroy
    @sale.destroy
    redirect_to sales_url, notice: 'Sale was successfully destroyed.'
  end
  
  def print
    @filename = 'my_report.pdf'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def sale_params
      params.require(:sale).permit(:code, :property_id, :bank_id, :grant_amount, :buyer_id, :contract_start_on, :registered_on, :purchase_price, :deposit_amount, :deposit_due_on, :attorney_id, :bond_attorney_id, :bond_due_on, :originator_id, :external_id, :commission, :vat, :status_id, :commissions_attributes => [:id, :agent_id, :commission_percent, :tax_percent, :gross_amount, :total_tax, :nett_amount, :deductions_attributes => [:id, :deductable_id, :amount, :_destroy]], :comments_attributes => [:id, :comments, :event_on])
    end
end
