class BanksController < ApplicationController
  before_action :set_bank, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # GET /banks
  def index
    @q = Bank.all.search(params[:q])
    @banks = @q.result.paginate(page: params[:page], per_page: params[:fetch]).decorate
  end

  # GET /banks/1
  def show
    @bank = @bank.decorate
  end

  # GET /banks/new
  def new
    @bank = Bank.new
  end

  # GET /banks/1/edit
  def edit
  end

  # POST /banks
  def create
    @bank = Bank.new(bank_params)

    if @bank.save
      redirect_to params[:commit_and_new] ? new_bank_path : @bank, notice: 'Bank was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /banks/1
  def update
    if @bank.update(bank_params)
      redirect_to @bank, notice: 'Bank was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /banks/1
  def destroy
    @bank.destroy
    redirect_to banks_url, notice: 'Bank was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank
      @bank = Bank.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def bank_params
      params.require(:bank).permit(:name)
    end
end
