class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    @category = Category.find(params[:category_id])
    @groups = @category.groups
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @category = Category.find(params[:category_id])

    if Group.exists?(:category_id => @category.id, :id => params[:id])
      @group = @category.groups.find(params[:id])
    else
      respond_to do |format|
        format.html { redirect_to :back, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
        end
    end
  end

  # GET /groups/new
  def new
    @category = Category.find(params[:category_id])
    @group = @category.groups.build
  end

  # GET /groups/1/edit
  def edit
    @category = Category.find(params[:category_id])

    if Group.exists?(:category_id => @category.id, :id => params[:id])
      @group = @category.groups.find(params[:id])
    else
        redirect_to categories_path
    end
  end

  # POST /groups
  # POST /groups.json
  def create
    @category = Category.find(params[:category_id])
    @group = @category.groups.create(params[:group])

    #Attach Products to groups
    #@products = Product.where(:id => params[:group_products])
    #@group.products << @products

    respond_to do |format|
      if @group.save
        format.html { redirect_to category_group_url(@category,@group), notice: 'Group was successfully created.' }
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
    category = Category.find(params[:category_id])
    @group = category.groups.find(params[:id])

    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to [@group.category, @group], notice: 'Group was successfully updated.' }
        #format.html { redirect_to :back, notice: 'Group was successfully updated.' }
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
    @category = Category.find(params[:category_id])
    @group = @category.groups.find(params[:id])

    @group.destroy
    respond_to do |format|
      format.html { redirect_to (category_groups_url), notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
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
