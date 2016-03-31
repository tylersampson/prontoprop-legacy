class CommissionsController < ApplicationController
  load_and_authorize_resource :agent
  load_and_authorize_resource through: :agent
  
  def index
    @commissions = @commissions.paginate(page: params[:page], per_page: params[:fetch]).decorate
    @total_due = @commissions.reject { |c| c.paid_on.present? }.map(&:total_payable).inject(0, &:+)
  end
  
  def pay
    Commission.find(params[:id]).update_attribute(:paid_on, Date.today)
    redirect_to :back, notice: "Commission has been marked as paid"
  end
  
  def pay_all
    Commission.where(agent_id: @agent.id, paid_on: nil).update_all(:paid_on => Date.today)
    redirect_to :back, notice: "All outstanding commissions have been marked as paid"
  end
end
