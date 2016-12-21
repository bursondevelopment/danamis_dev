# encoding: UTF-8
class ActoresController < ApplicationController
  # GET /actores
  # GET /actores.json
  before_filter :filtro_logueado
  def index
    @actores = Actor.order('nombres ASC')
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @actores }
    end
  end

  # GET /actores/1
  # GET /actores/1.json
  def show
    @actor = Actor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @actor }
    end
  end

  # GET /actores/new
  # GET /actores/new.json
  def new
    @actor = Actor.new
    @actor.organizacion_id = params[:organizacion_id] if params[:organizacion_id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @actor }
    end
  end

  # GET /actores/1/edit
  def edit
    @actor = Actor.find(params[:id])
    @organizacion = params[:organizacion_id] if params[:organizacion_id] 
  end

  # POST /actores
  # POST /actores.json
  def create
    @actor = Actor.new(params[:actor])

    respond_to do |format|
      if @actor.save
        if params[:organizacion]
          format.html { redirect_to "/organizaciones/#{@actor.organizacion_id}", notice: 'Actor registrado con éxito.' }
        else
          format.html { redirect_to @actor, notice: 'Actor registrado con éxito.' }
        end
        format.json { render json: @actor, status: :created, location: @actor }
      else
        format.html { render action: "new" }
        format.json { render json: @actor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /actores/1
  # PUT /actores/1.json
  def update
    @actor = Actor.find(params[:id])
    respond_to do |format|
      if @actor.update_attributes(params[:actor])

        if params[:organizacion]
          format.html { redirect_to "/organizaciones/#{@actor.organizacion_id}", notice: 'Actor actualizado con éxito.' }
        else
          format.html { redirect_to @actor, notice: 'Actor actualizado con éxito.' }
        end
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @actor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /actores/1
  # DELETE /actores/1.json
  def destroy
    @actor = Actor.find(params[:id])
    @actor.destroy

    respond_to do |format|
      if params[:organizacion]
        format.html { redirect_to "/organizaciones/#{params[:organizacion]}", notice: 'Actor eliminado del sistema.' }
      else
        format.html { redirect_to actores_url, notice: 'Actor eliminado del sistema.' }
      end
      format.json { head :no_content }
    end
  end
end
