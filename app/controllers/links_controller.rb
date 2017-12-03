class LinksController < ApplicationController
  before_action :signed_in_user
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  # GET /links
  # GET /links.json
  def index
    #@links = Link.all
    @user = User.find(current_user.id)
    @links = @user.links
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    #@link = Link.new(link_params)
    @user = User.find(current_user.id)
    @link = @user.links.new(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:sort, :description, :link, :enabled)
    end

    def correct_user
      @user = User.find(Link.find(params[:id]).user_id)
      unless current_user?(@user)
        logger.warn("Invalid access on Links. #{current_user.email} to #{request.method} #{request.url}")
        redirect_to root_path, notice: "Please signin with correct user."
      end
    end

    def current_user?(user)
      user == current_user
    end

end
