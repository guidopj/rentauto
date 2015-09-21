package ar.edu.unq.epers.services

import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.persistens.AutoHome
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.sesiones.SessionManager

@Accessors
class AutoService {
	
	AutoHome autoHome
	
	new(AutoHome autoH){
		this.autoHome = autoH
	}
	
	def anadirAuto(String marca, String modelo, Integer anio, String patente, Double costoBase){
		SessionManager.runInSession([
			val Auto auto = new Auto(marca, modelo, anio, patente,costoBase);
			this.autoHome.guardarAuto(auto);
		]);
	}
}