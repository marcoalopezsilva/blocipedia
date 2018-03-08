class WikisController < ApplicationController
  before_action :set_wiki, only: [:show, :edit, :update, :destroy]

  # GET /wikis
  # GET /wikis.json
  def index
    @wikis = Wiki.all
  end

  # GET /wikis/1
  # GET /wikis/1.json
  def show
  end

  # GET /wikis/new
  def new
    @wiki = Wiki.new
  end

  # GET /wikis/1/edit
  def edit
  end

  # POST /wikis
  # POST /wikis.json
  def create
    #@wiki = Wiki.new(wiki_params)
    @wiki = Wiki.new(wiki_params)
    #@wiki.user_id = current_user.id
    @wiki.user = current_user
    #@wiki.user.email = current_user.email
    respond_to do |format|
      if @wiki.save
        format.html { redirect_to @wiki, notice: 'Wiki was successfully created.' }
        #format.html { redirect_to @wiki}
        format.json { render :show, status: :created, location: @wiki }
      else
        format.html { render :new }
        format.json { render json: @wiki.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wikis/1
  # PATCH/PUT /wikis/1.json
  def update
    authorize @wiki
    respond_to do |format|
      if @wiki.update(wiki_params)
        format.html { redirect_to @wiki, notice: 'Wiki was successfully updated.' }
        #format.html { redirect_to @wiki}
        format.json { render :show, status: :ok, location: @wiki }
      else
        format.html { render :edit }
        format.json { render json: @wiki.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wikis/1
  # DELETE /wikis/1.json
  def destroy
    #Next line consults WikiPolicy's destroy? method ("autorizes current_user") before continuing
    authorize @wiki
    @wiki.destroy
    redirect_to wikis_url, notice: 'Wiki was successfully destroyed.'
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_wiki
      @wiki = Wiki.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wiki_params
      #params.require(:wiki).permit(:title, :body, :private, :user_id)
      #NL: Removed 'user_id' from permitted parameters list
      params.require(:wiki).permit(:title, :body, :private)
    end
end
