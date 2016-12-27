class Clave < ActiveRecord::Base
  belongs_to :entorno
  attr_accessible :incluyente, :valor, :entorno_id

  validates_presence_of :valor, :entorno_id
  validates :valor, :uniqueness => {:scope => :entorno_id}

  scope :incluyentes, -> {where(incluyente: true)}

  scope :excluyentes, -> {where(incluyente: false)}


  def self.dividir_palabras palabras
  	palabras_a = palabras.split(";")
  	palabras_a.each do |pa|
  		puts pa
  	end
  end
end
