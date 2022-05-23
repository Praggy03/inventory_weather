class InventoriesController < ApplicationController
  layout "home"
  before_action :set_inventory, only: %i[ show edit update destroy ]

  def index
    @inventories = Inventory.all || []
    @inventories = @inventories.order(params[:sort]) if params[:sort].present?
  end

  def show
  end

  def new
    @inventory = Inventory.new
  end

  def edit
  end

  def create
    @inventory = Inventory.new(inventory_params)

    respond_to do |format|
      if @inventory.save
        format.html { redirect_to inventory_url(@inventory), notice: I18n.t("inventory.created") }
        format.json { render :show, status: :created, location: @inventory }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      quantity = inventory_params[:quantity].to_i
      if @inventory.update(inventory_params.except(:quantity)) && @inventory.check_and_update_quantity(quantity)
        format.html { redirect_to inventory_url(@inventory), notice: I18n.t("inventory.updated") }
        format.json { render :show, status: :ok, location: @inventory }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @inventory.destroy
      respond_to do |format|
        format.html { redirect_to inventories_url, notice: I18n.t("inventory.destroyed") }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to inventories_url, notice: I18n.t("cannot_destroy_item") }
        format.json { head :no_content }
      end
    end
  end

  private
    def set_inventory
      @inventory = Inventory.find_by(id: params[:id])
    end

    def inventory_params
      params.require(:inventory).permit(:name, :description, :status, :quantity)
    end
end
