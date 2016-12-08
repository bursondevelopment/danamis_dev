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

  def filtro_logueado_ssj
    unless session[:usuario]
      flash[:alert] = "Debe iniciar sesión"  
      redirect_to :root
      return false
    else
    	usuario = session[:usuario]
    	unless usuario.ssj?
    		flash[:alert] = "Ud. no es usuario ssj"  
      		redirect_to :root
      		return false
      	end
    end
  end


end
