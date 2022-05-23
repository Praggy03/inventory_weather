class ShipmentsController < ApplicationController
  layout "home"
  before_action :set_shipment, only: %i[ show edit update destroy ]

  # GET /shipments or /shipments.json
  def index
    @shipments = Shipment.all
  end

  # GET /shipments/1 or /shipments/1.json
  def show
    # @inventories = @shipment.inventory
    @mappings = ShipmentInventoryMapping.includes(:inventory).where(shipment_id: @shipment.id)

    print(@inventories)
  end

  # GET /shipments/new
  def new
    @shipment = Shipment.new
  end

  # GET /shipments/1/edit
  def edit
  end

  # POST /shipments or /shipments.json
  def create
    @shipment = Shipment.new(shipment_params)

    respond_to do |format|
      if @shipment.save
        format.html { redirect_to shipment_url(@shipment), notice: I18n.t("shipment.created") }
        format.json { render :show, status: :created, location: @shipment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shipments/1 or /shipments/1.json
  def update
    respond_to do |format|
      if @shipment.update(shipment_params)
        format.html { redirect_to shipment_url(@shipment), notice: I18n.t("shipment.updated") }
        format.json { render :show, status: :ok, location: @shipment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shipments/1 or /shipments/1.json
  def destroy
    @mappings = ShipmentInventoryMapping.where(shipment_id: @shipment.id)
    if !@mappings.present? && @shipment.destroy
      respond_to do |format|
        format.html { redirect_to shipments_url, notice: I18n.t("shipment.destroyed") }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to shipments_url, notice: I18n.t("cannot_destroy_item") }
        format.json { head :no_content }
      end
    end
  end

  def add_inventory
    @shipment = Shipment.find_by id: params[:id]
    @mapping = ShipmentInventoryMapping.new
  end

  def assign_inventory
    mapping_params = params[:shipment_inventory_mapping]
    @shipment = Shipment.find_by id: params[:id]
    @inventory = Inventory.find_by id: mapping_params[:inventory_id]
    quantity = mapping_params[:quantity].to_i
    if quantity > 0 && quantity <= @inventory.quantity
      @shipment.add_inventory(@inventory, quantity)
      respond_to do |format|
        format.html { redirect_to shipment_url(@shipment), notice: I18n.t("shipment.add_inventory_success") }
        format.json { render :show, status: :created, location: @shipment }
      end
    else
      respond_to do |format|
        format.html { redirect_to add_inventory_shipment_url(@shipment), notice: I18n.t("shipment.add_inventory_failure") }
        format.json { render json: @shipment.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_inventory
    @shipment = Shipment.find_by id: params[:id]
    @inventory = Inventory.find_by id: params[:inventory_id]
    if @shipment.remove_inventory(@inventory)
      respond_to do |format|
          format.html { redirect_to shipment_url(@shipment), notice: I18n.t("shipment.remove_inventory") }
          format.json { render :show, status: :ok, location: @shipment }
      end
    else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @shipment.errors, status: :unprocessable_entity } 
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shipment
      @shipment = Shipment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shipment_params
      params.require(:shipment).permit(:name, :description, :source_id, :destination_id)
    end
end
