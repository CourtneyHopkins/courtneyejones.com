class ItemsController < ApplicationController
  before_filter :require_user
  layout "admin"
  # GET /items
  # GET /items.json
  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        if params[:item][:assignments] && !params[:item][:assignments].empty?
          params[:item][:assignments].split(",").each do |a|
            c = Category.find(a)
            if c
              CategoryItem.create({
                category_id: c.id, 
                item_id: @item.id
              })
            end
          end
        end
        
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        if params[:item][:assignments]
          new_ass = params[:item][:assignments].split(",")
          old_ass = @item.categories.collect{|c| c.id }
          
          old_ass.each do |a|
            if new_ass.include?(a)
              # the assignment stays
            else
              # assignment needs removed
              asses = @item.category_items.where(category_id: a)
              asses.each{|a| a.destroy}
            end
          end
          params[:item][:assignments].split(",").each do |a|
            c = Category.find(a)
            if c
              CategoryItem.create({
                category_id: c.id, 
                item_id: @item.id
              })
            end
          end
        end
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end
end
