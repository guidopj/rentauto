package ar.edu.unq.epers.services

import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.persistens.AutoHome
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.sesiones.SessionManager
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.Ubicacion

@Accessors
class AutoService {
	
	AutoHome autoHome
	
	new(AutoHome autoH){
		this.autoHome = autoH
	}
	
	def anadirAuto(String marca, String modelo, Integer anio, String patente, Categoria categoria,Double costoBase, Ubicacion ubicacionInicial){
		SessionManager.runInSession([
			val Auto auto = new Auto(marca, modelo, anio, patente,categoria,costoBase,ubicacionInicial);
			this.autoHome.guardarAuto(auto);
		]);
	}
	
	def getAuto(int id){
		SessionManager.runInSession([
			this.autoHome.obtenerAuto(id);
		]);
	}
}