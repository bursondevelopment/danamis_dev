class Usuario < ActiveRecord::Base
  attr_accessible :contrasena, :correo, :nombre, :nombre_sesion, :contrasena_confirmation, :tipo
  validates_confirmation_of :contrasena

  validates_presence_of :nombre, :nombre_sesion, :tipo, :contrasena

  has_many :organizaciones
  accepts_nested_attributes_for :organizaciones
  
  def self.autenticar(nombre_sesion,contrasena)
    Usuario.where(:nombre_sesion => nombre_sesion, :contrasena => contrasena).limit(1).first
  end

  def ssj?
  	nombre_sesion.eql? "dmoros"
  end

  def super_usuario?
    tipo.eql? 1
  end

  def usuario_admin?
    tipo < 3
  end

  def tipo_usuario
    if tipo.eql? 1
      return 'SuperAdministrador'
    elsif tipo.eql? 2
      return 'Administrador'
    else
      return 'Usuario'
    end
  end


  def self.all_tipo
    [[1,'SuperAdmin'],[2,'Admin'],[3,'Usuario']]
  end

end
