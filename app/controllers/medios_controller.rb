# encoding: UTF-8
class MediosController < ApplicationController
  # GET /medios
  # GET /medios.json
  before_filter :filtro_logueado
  before_filter :filtro_logueado_admin


  def barrer
    if params[:id]
      @medio = Medio.find(params[:id])
      total = @medio.importar_notas_medios_web

      if total.is_a? Numeric and total > 0 
        flash[:success] = "Barrido exitoso de #{total} página(s)."
      else
        flash[:alert] = "No se cargaron nuevas páginas. Error: #{total}"
      end
      
    else
      @medios = Medio.digitales
      total = ""
      @medios.each do |medio|
        total += "#{medio.descripcion}: #{medio.importar_notas_medios_web} |"
      end
      flash[:success] = "#{total.split('|')}"
    end
            
    redirect_to :back
  end

  def barrer_ordinal
      ordinal = params[:id].to_i
      @medio = Medio.digitales[ordinal]
      @medio.importar_notas_medios_web
      #sleep 1.5
      redirect_to :back, status: :created

=begin
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
      end
=end
  end


  def index
    @medios = Medio.digitales.order('nombre ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @medios }
    end
  end

  def index_impresos
    @medios = Medio.impresos.order('nombre ASC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @medios }
    end
  end


  # GET /medios/1
  # GET /medios/1.json
  def show
    @medio = Medio.find(params[:id])
    @estructura = EstructuraMedio.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @medio }
    end
  end

  # GET /medios/new
  # GET /medios/new.json
  def new
    @medio = Medio.new
    if params[:impreso]
      @tipo_medio = TipoMedio.find_by_description ('impreso')
      @medio.tipo_medio_id = @tipo_medio.id 
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @medio }
    end
  end

  # GET /medios/1/edit
  def edit
    @medio = Medio.find(params[:id])
  end

  # POST /medios
  # POST /medios.json
  def create
    @medio = Medio.new(params[:medio])
    @medio.descripcion = @medio.nombre if @medio.tipo_medio.impreso?

    respond_to do |format|
      if @medio.save
        flash[:success] = "Medio agregado con éxito"
        if @medio.tipo_medio.impreso?
          format.html { redirect_to action: 'index_impresos', notice: 'Medio registrado con éxito.' }
        else
          format.html { redirect_to @medio, notice: 'Medio registrado con éxito.' }
          format.json { render json: @medio, status: :created, location: @medio }
        end
      else
        flash[:alert] = "Error al intentar guardar el medio: #{@medio.errors.full_messages.join(". ")}"
        if @medio.tipo_medio.impreso?
          @tipo_medio = TipoMedio.find_by_description ('impreso')
          @medio.tipo_medio_id = @tipo_medio.id
        end
          format.html { render action: "new" }
      end
    end
  end

  # PUT /medios/1
  # PUT /medios/1.json
  def update
    @medio = Medio.find(params[:id])

    respond_to do |format|
      if @medio.update_attributes(params[:medio])
        format.html { redirect_to @medio, notice: 'Medio actualizado con éxito.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @medio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medios/1
  # DELETE /medios/1.json
  def destroy
    @medio = Medio.find(params[:id])
    @medio.destroy

    respond_to do |format|
      format.html { redirect_to medios_url }
      format.json { head :no_content }
    end
  end
end
