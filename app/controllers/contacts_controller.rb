class ContactsController < ApplicationController
  def index
    @q = Contact.all.search(params[:q])
    @contacts = @q.result.paginate(page: params[:page], per_page: params[:fetch]).decorate
  end
end
