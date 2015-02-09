class GroupsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :show]
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    #Order Item for product
    @order_item = current_order.order_items.new
  end

  # GET /groups/new
  def new
    unless @admin == current_user
      redirect_to root_path, :alert => "Access denied."
    end

    @group = Group.new
  end

  # GET /groups/1/edit
  def edit

    #--Authorize--
    unless @admin == current_user
      redirect_to root_path, :alert => "Access denied."
    end
  end

  # POST /groups
  # POST /groups.json
  def create

    @group = Group.new(group_params)


    respond_to do |format|
      if @group.save
        format.html { redirect_to @group, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @group }

      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update

    respond_to do |format|
      if @group.update(group_params)

        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    if @admin == current_user


      @group.destroy
      respond_to do |format|
        format.html { redirect_to (groups_url), notice: 'Group was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_path, :alert => "Access denied."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :description, :category_id, :image)
    end
end
