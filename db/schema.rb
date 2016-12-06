# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20161206010023) do

  create_table "actores", :force => true do |t|
    t.string   "nombres"
    t.string   "cargo"
    t.integer  "tolda_id"
    t.integer  "organizacion_id"
    t.boolean  "representante_legal"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "actores", ["organizacion_id"], :name => "index_actores_on_organizacion_id"
  add_index "actores", ["tolda_id"], :name => "index_actores_on_tolda_id"

  create_table "adjuntos", :force => true do |t|
    t.string   "titulo"
    t.string   "sumario"
    t.string   "fecha"
    t.string   "autor"
    t.integer  "medio_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "adjuntos", ["medio_id"], :name => "index_adjuntos_on_medio_id"

  create_table "ambitos", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "clases", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "claves", :force => true do |t|
    t.string   "valor"
    t.boolean  "incluyente"
    t.integer  "entorno_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "claves", ["entorno_id"], :name => "index_claves_on_entorno_id"

  create_table "entornos", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "especializaciones_medio", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "estructuras_medios", :force => true do |t|
    t.string   "url"
    t.string   "articulo"
    t.string   "titulo"
    t.string   "contenido"
    t.string   "imagen"
    t.string   "fecha"
    t.integer  "medio_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "estructuras_medios", ["medio_id"], :name => "index_estructuras_medios_on_medio_id"

  create_table "externas", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "informes", :force => true do |t|
    t.datetime "fecha"
    t.string   "encabezado"
    t.string   "titulo"
    t.string   "autor"
    t.string   "tema"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "internas", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "medio_organizaciones", :id => false, :force => true do |t|
    t.integer  "organizacion_id"
    t.integer  "medio_id"
    t.boolean  "propio"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "medio_organizaciones", ["medio_id", "organizacion_id"], :name => "index_medio_organizaciones_on_medio_id_and_organizacion_id", :unique => true
  add_index "medio_organizaciones", ["medio_id"], :name => "index_medio_organizaciones_on_medio_id"
  add_index "medio_organizaciones", ["organizacion_id"], :name => "index_medio_organizaciones_on_organizacion_id"

  create_table "medios", :force => true do |t|
    t.string   "nombre"
    t.string   "logo"
    t.string   "descripcion"
    t.integer  "impacto"
    t.integer  "tipo_medio_id"
    t.integer  "tipo_especializacion_id"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "medios", ["tipo_especializacion_id"], :name => "index_medios_on_tipo_especializacion_id"
  add_index "medios", ["tipo_medio_id"], :name => "index_medios_on_tipo_medio_id"

  create_table "organizaciones", :force => true do |t|
    t.string   "razon_social"
    t.integer  "entorno_id"
    t.integer  "interna_id"
    t.integer  "externa_id"
    t.integer  "ambito_id"
    t.integer  "clase_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "organizaciones", ["ambito_id"], :name => "index_organizaciones_on_ambito_id"
  add_index "organizaciones", ["clase_id"], :name => "index_organizaciones_on_clase_id"
  add_index "organizaciones", ["entorno_id"], :name => "index_organizaciones_on_entorno_id"
  add_index "organizaciones", ["externa_id"], :name => "index_organizaciones_on_externa_id"
  add_index "organizaciones", ["interna_id"], :name => "index_organizaciones_on_interna_id"

  create_table "productos", :force => true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "productos_marcas", :id => false, :force => true do |t|
    t.integer  "producto_id"
    t.integer  "marca_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "productos_marcas", ["marca_id"], :name => "index_productos_marcas_on_marca_id"
  add_index "productos_marcas", ["producto_id", "marca_id"], :name => "index_productos_marcas_on_producto_id_and_marca_id", :unique => true
  add_index "productos_marcas", ["producto_id"], :name => "index_productos_marcas_on_producto_id"

  create_table "reportes", :force => true do |t|
    t.string   "argumento"
    t.string   "titulo"
    t.string   "fecha"
    t.integer  "autor_id"
    t.integer  "informe_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "reportes", ["autor_id"], :name => "index_reportes_on_autor_id"
  add_index "reportes", ["informe_id"], :name => "index_reportes_on_informe_id"

  create_table "reportes_adjuntos", :id => false, :force => true do |t|
    t.integer  "reporte_id", :null => false
    t.integer  "adjunto_id", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "reportes_adjuntos", ["adjunto_id"], :name => "index_reportes_adjuntos_on_adjunto_id"
  add_index "reportes_adjuntos", ["reporte_id", "adjunto_id"], :name => "index_reportes_adjuntos_on_reporte_id_and_adjunto_id", :unique => true
  add_index "reportes_adjuntos", ["reporte_id"], :name => "index_reportes_adjuntos_on_reporte_id"

  create_table "tipo_especializaciones", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tipos_medios", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "toldas", :force => true do |t|
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
