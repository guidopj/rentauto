package ar.edu.unq.epers.services

import java.util.Date
import ar.edu.unq.epers.persistens.CacheHome
import ar.edu.unq.epers.model.Ubicacion

class CacheService {
	
	CacheHome cacheHome
	
	new(CacheHome ch){
		this.cacheHome = ch
	}
	
	def getAutosDisponiblesPorFecha(Date dia){
		this.cacheHome.obtenerAutosPorDia(dia)
	}
	
	def getAutosDisponiblesPorUbicacion(String ubi){
		this.cacheHome.obtenerAutosPorUbicacion(ubi)
	}
	
}