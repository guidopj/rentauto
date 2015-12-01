package ar.edu.unq.epers.services

import ar.edu.unq.epers.persistens.AutoHome
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.sesiones.SessionManager
import ar.edu.unq.epers.model.Ubicacion
import java.util.Date
import ar.edu.unq.epers.model.Reserva
import java.util.List
import ar.edu.unq.epers.model.Auto
import java.util.ArrayList
import org.eclipse.xtext.xbase.lib.Functions.Function0
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.persistens.CacheHome

@Accessors
class RentAutoService {
	
	AutoHome autoHome
	CacheHome cacheHome
	
	new(AutoHome autoH){
		this.autoHome = autoH
	}
	
	def <T> ejecutarBloque(Function0< T> bloque) {
		SessionManager.runInSession([
			bloque.apply();
		]);
	}

	def <T> anadir(T element){
		this.ejecutarBloque([|
			this.autoHome.guardar(element);
		]);
	}
	
	def getAuto(int id){
		this.ejecutarBloque([|
			this.autoHome.obtenerAuto(id);
		]);
	}
	
	def private esMismaUbicacion(String u, String u1){
		u.equals(u1)
	}
	
	
	def private tieneReservaDesdeInicio(Auto a, Date fecha){
		for(Reserva r : a.reservas){
			if(r.inicio.after(fecha)){
				return true
			}
		}
		false
	}
	
	def private tieneReservaHastaFin(Auto a, Date fecha){
		for(Reserva r : a.reservas){
			if(r.fin.before(fecha)){
				return true
			}
		}
		false
	}
	
//	def obtenerAutosDisponibles(Ubicacion ubicacion, Date fecha) {
//		this.ejecutarBloque([|
//			var List<Auto> autosDisponibles = new ArrayList<Auto>
//			var List<Auto> autos = this.autoHome.obtenerAutos()
//			for(Auto a : autos){
//				if(esMismaUbicacion(a.ubicacionInicial,ubicacion) && !tieneReservaEn(a,fecha)){
//					autosDisponibles.add(a)
//				}
//			}
//			autosDisponibles 
//		]);
//	}
	
	
//	def obtenerAutosDisponibles(String origen,Date inicio,Date fin,Categoria cat) {
//		//agregar la cache  verificar que nada rompa
//		this.ejecutarBloque([|
//			var List<Auto> autosDisponibles = new ArrayList<Auto>
//			var List<Auto> autos
//			if(hayDisponibilidadEnCache(origen,inicio,fin)){
//				autos = this.cacheHome.obtenerAutosPorUbicacionYDia(origen,inicio,fin) as List<Auto>
//			}else{
//				autos = this.autoHome.obtenerAutos()	
//			}
//			for(Auto a : autos){
//				if(satisfaceFiltro(a,origen,inicio,fin,cat)){
//					autosDisponibles.add(a)
//				}
//			}
//			autosDisponibles 
//		]);
//	}
	
//	def satisfaceFiltro(Auto auto,String origen, Date inicio, Date fin, Categoria categoria) {
//		var boolRes = true
//		if(origen != null){
//			boolRes = boolRes && esMismaUbicacion(origen,auto.ubicacionInicial)
//		}
//		if(inicio != null){
//			boolRes = boolRes && tieneReservaDesdeInicio(auto,inicio)
//		}
//		if(fin != null){
//			boolRes = boolRes && tieneReservaHastaFin(auto,fin)
//		}
//		if(categoria != null){
//			boolRes = boolRes && tieneMismaCategoria(auto,categoria)
//		}
//		boolRes
//	}
	
	def tieneMismaCategoria(Auto auto, Categoria categoria) {
		auto.categoria.nombre.equals(categoria.nombre)
	}
	
	def obtenerTotalAutos() {
		this.ejecutarBloque([|
			return this.autoHome.obtenerAutos()
		]);
	}
	
	def obtenerReservaPorNumeroSolicitud(Integer numSolicitud) {
		this.ejecutarBloque([|
			return this.autoHome.obtenerReservaPorNumeroSolicitud(numSolicitud)
		]);
	}
	
	def realizarReserva(Reserva reservaNueva) {
		//Auto auto,Ubicacion origen,Ubicacion destino,Date inicio,Date fin
		reservaNueva.reservar()
		this.anadir(reservaNueva)
	}
	
}