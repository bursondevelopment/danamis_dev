class Adjunto < ActiveRecord::Base
  attr_accessible :autor, :fecha, :sumario, :titulo, :medio_id, :url, :valida

  belongs_to :medio
  accepts_nested_attributes_for :medio

  validates_presence_of :medio_id, :titulo, :url
  validates :url, :uniqueness => true



  # SCOPE INTERESANTES
  # scope :chavismo, joins(:organizacion).where('organizaciones.tolda_id = 2')
  # scope :por_cuna, lambda {|cuna_id| where(:cuna_id => cuna_id)}
  # scope :organizacion, lambda {|name| where(["name ILIKE ? OR aliases ILIKE ?","%#{name}%","%#{name}%"])}
  # scope :creadas_hoy_no_incluidas_en_resumen, -> resumen_id {creadas_hoy.validas.where("resumen_id != ? OR resumen_id IS ?", resumen_id, nil)}

  scope :buscar_clave_general, lambda {|clave| where('sumario LIKE ? OR titulo LIKE ? OR autor LIKE ? OR url LIKE ?',"%#{clave}%","%#{clave}%","%#{clave}%","%#{clave}%")}
    
  scope :creadas_hoy, -> {where("created_at >= ?", Date.today)}
  
  scope :creadas_antes_de_hoy, -> {where("created_at < ?", Date.today)}
  
  scope :validas, -> {where(:valida => true )}


  def descripcion
    nota = ""
    nota += fecha if fecha
    nota += "#{nota} #{autor}" if autor
    nota = "<b>#{nota}</b>: "
    nota += " <em>#{titulo}</em>"
  end

  def descripcion_completa
    descripcion + sumario
  end

end
