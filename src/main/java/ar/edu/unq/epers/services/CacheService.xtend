package ar.edu.unq.epers.services

import ar.edu.unq.epers.model.AutoCassandra
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.persistens.CacheHome
import com.datastax.driver.core.ResultSet
import com.datastax.driver.core.Row
import java.util.ArrayList
import java.util.Date
import java.util.List

class CacheService {
	
	CacheHome cacheHome
	
//	listaDisponibilidad.filter[d | (inicioABuscar.after(d.inicio) || inicioABuscar.equals(d.inicio))
//			                           && (finABuscar.before(d.fin) || finABuscar.equals(d.inicio))]
	new(CacheHome ch){
		this.cacheHome = ch
	}
	
	def getAutosDisponiblesPorUbicacionYDia(String ubi,Date inicioABuscar,Date finABuscar){
		this.cacheHome.obtenerAutosPorUbicacionYDia(ubi,inicioABuscar,finABuscar)
	}
	
}