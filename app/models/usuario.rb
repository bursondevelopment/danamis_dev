class Usuario < ActiveRecord::Base
  attr_accessible :contrasena, :correo, :nombre, :nombre_sesion, :contrasena_confirmation
  validates_confirmation_of :contrasena

  has_many :organizaciones
  accepts_nested_attributes_for :organizaciones
  
  def self.autenticar(nombre_sesion,contrasena)
    Usuario.where(:nombre_sesion => nombre_sesion, :contrasena => contrasena).limit(1).first
  end

  def ssj?
  	nombre_sesion.eql? "dmoros"
  end
end
