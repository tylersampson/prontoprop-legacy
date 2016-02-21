class AgentsController < ApplicationController
  load_and_authorize_resource

  # GET /agents
  def index
    @q = @agents.search(params[:q])
    @agents = @q.result.paginate(page: params[:page], per_page: params[:fetch]).decorate
  end

  # GET /agents/1
  def show    
  end

  # GET /agents/new
  def new
  end

  # GET /agents/1/edit
  def edit
  end

  # POST /agents
  def create
    if @agent.save
      redirect_to params[:commit_and_new] ? new_agent_path : @agent, notice: 'Agent was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /agents/1
  def update
    if @agent.update(agent_params)
      redirect_to @agent, notice: 'Agent was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /agents/1
  def destroy
    @agent.destroy
    redirect_to agents_url, notice: 'Agent was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agent
      @agent = Agent.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def agent_params
      params.require(:agent).permit(:code, :first_name, :last_name, :id_number, :email, :mobile, :tax)
    end
end
