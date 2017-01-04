class Reporte < ActiveRecord::Base
  belongs_to :actor
  belongs_to :informe
  belongs_to :organizacion


  attr_accessible :argumento, :fecha, :titulo, :actor_id, :informe_id, :organizacion_id, :orden


  validates_presence_of :titulo, :argumento, :actor_id
#  validates :razon_social, :uniqueness => true

  has_and_belongs_to_many :adjuntos, :join_table => "reportes_adjuntos"
  accepts_nested_attributes_for :adjuntos

  has_many :reportes_adjuntos, :dependent => :destroy
  accepts_nested_attributes_for :reportes_adjuntos



# SCOPES
  scope :sin_informe, -> {where("informe_id IS NULL")}

  scope :creados_hoy, -> {where("created_at >= ?", Date.today)}
  scope :creados_antes_de_hoy, -> {where("created_at < ?", Date.today)}

  scope :del_cliente, lambda {|cliente_id| where(:organizacion_id => cliente_id)}

  scope :clientes, -> {where("seccion = 'cliente'")}
  scope :competencias, -> {where("seccion = 'competencia'")}
  scope :actividad, -> {where("seccion = 'actividad'")}

  scope :pendientes, -> {where("seccion NOT LIKE 'cliente' AND seccion NOT LIKE 'competencia' AND seccion NOT LIKE 'actividad' OR seccion IS NULL")}


  def palabras_claves
    aux = ""
    aux += actor.organizacion.entorno.claves.collect{|clave| clave.valor}.join(",") if (actor and actor.organizacion and actor.organizacion.entorno and actor.organizacion.entorno.claves )
    return aux 
  end

end
