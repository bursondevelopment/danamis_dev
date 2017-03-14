class Adjunto < ActiveRecord::Base
  attr_accessible :autor, :fecha, :sumario, :titulo, :medio_id, :url, :valida

  belongs_to :medio
  accepts_nested_attributes_for :medio

  validates_presence_of :medio_id, :titulo, :url
  validates :url, :uniqueness => true, if: :digital?

  has_and_belongs_to_many :reportes, :join_table => "reportes_adjuntos"
  accepts_nested_attributes_for :reportes

  has_and_belongs_to_many :organizaciones, :join_table => "adjunto_organizaciones"
  accepts_nested_attributes_for :organizaciones

  has_many :adjunto_organizaciones, :dependent => :destroy
  accepts_nested_attributes_for :adjunto_organizaciones

  has_and_belongs_to_many :reportes, :join_table => "reportes_adjuntos"
  accepts_nested_attributes_for :reportes

  has_many :reportes_adjuntos, :dependent => :destroy
  accepts_nested_attributes_for :reportes_adjuntos

  # SCOPE INTERESANTES
  # scope :chavismo, joins(:organizacion).where('organizaciones.tolda_id = 2')
  # scope :por_cuna, lambda {|cuna_id| where(:cuna_id => cuna_id)}
  # scope :organizacion, lambda {|name| where(["name ILIKE ? OR aliases ILIKE ?","%#{name}%","%#{name}%"])}
  # scope :creadas_hoy_no_incluidas_en_resumen, -> resumen_id {creadas_hoy.validas.where("resumen_id != ? OR resumen_id IS ?", resumen_id, nil)}

  scope :buscar_clave_general, lambda {|clave| where('sumario LIKE ? OR titulo LIKE ? OR autor LIKE ? OR url LIKE ?',"%#{clave}%","%#{clave}%","%#{clave}%","%#{clave}%")}
    
  scope :creadas_hoy, -> {where("adjuntos.created_at >= ?", Date.today)}
  
  scope :creadas_antes_de_hoy, -> {where("created_at < ?", Date.today)}
  
  scope :validas, -> {where(:valida => true )}

  scope :con_reportes, -> {where("id IN (#{ReporteAdjunto.all.collect{|x| x.adjunto_id}.join(",")})")}

  scope :sin_reportes, -> {where("id NOT IN (#{ReporteAdjunto.all.collect{|x| x.adjunto_id}.join(",")})")}

  scope :del_cliente, lambda {|cliente_id| joins(:adjunto_organizaciones).where('adjunto_organizaciones.organizacion_id = ?', cliente_id)}

  scope :del_cliente_hoy, lambda {|cliente_id| joins(:adjunto_organizaciones).where('adjunto_organizaciones.organizacion_id = ? AND adjuntos.created_at >= ?',cliente_id, Date.today)}
  scope :del_cliente_antes_hoy, lambda {|cliente_id| joins(:adjunto_organizaciones).where('adjunto_organizaciones.organizacion_id = ? AND adjuntos.created_at < ?',cliente_id, Date.today)}

  scope :del_cliente_con_reporte, lambda {|cliente_id| where("id IN (#{(Reporte.del_cliente cliente_id).collect{|x| x.reportes_adjuntos.collect{|y| y.adjunto_id}}.flatten.join(",")})")}

  scope :del_cliente_sin_reporte, lambda {|cliente_id| where("id NOT IN (#{(Reporte.del_cliente cliente_id).collect{|x| x.reportes_adjuntos.collect{|y| y.adjunto_id}}.flatten.join(",")})")}

  def impreso?
    medio.tipo_medio.impreso?
  end

  def digital?
    medio.digital?
  end

  def valida2 cliente_id
      Adjunto.del_cliente_hoy(cliente_id).collect{|x| x.id}.include? id
  end

  def imagen_url
    "/assets/adjuntos/"+url.split('/').last.downcase
  end

  def descripcion
    nota = ""
    nota += fecha if fecha
    nota += "#{nota} #{autor}" if autor
    nota = "<b>#{nota}: </b>" unless nota.blank?
    nota += " <em>#{titulo}</em>"
  end

  def descripcion_completa
    "#{descripcion}. #{sumario}"
  end

  def extension
    url.split(".").last
  end

  def nombre_mail
    "adjunto_#{id}.#{extension}"
  end

end
