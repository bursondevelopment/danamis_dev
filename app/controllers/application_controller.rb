# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
private  
  def filtro_logueado
    unless session[:usuario]
      flash[:alert] = "Debe iniciar sesión"  
      redirect_to :root
      return false
    end
  end

  def filtro_logueado_dunamis
    unless session[:usuario]
      flash[:alert] = "Debe iniciar sesión"  
      redirect_to :root
      return false
    else
    	usuario = session[:usuario]
    	unless usuario.super_usuario?
    		flash[:alert] = "Ud. no es un Super Administrador"  
      		redirect_to :back
      		return false
      	end
    end
  end

  def filtro_logueado_admin
    unless session[:usuario]
      flash[:alert] = "Debe iniciar sesión"  
      redirect_to :root
      return false
    else
      usuario = session[:usuario]
      unless usuario.super_usuario?
        flash[:alert] = "Ud. no es un Super Administrador"  
          redirect_to :back
          return false
        end
    end
  end


end
