class DashboardsController < ApplicationController  
  def show
    @sales = Sale.in_range params[:from], params[:to]
    @preferred_originators = Originator.where(preferred: true)
  end
end
