package ar.edu.unq.epers.services

import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Categoria
import ar.edu.unq.epers.model.DisponibilidadAuto
import ar.edu.unq.epers.model.Reserva
import ar.edu.unq.epers.model.Ubicacion
import ar.edu.unq.epers.persistens.AutoHome
import ar.edu.unq.epers.sesiones.SessionManager
import java.util.ArrayList
import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtext.xbase.lib.Functions.Function0

@Accessors
class RentAutoService {
	
	AutoHome autoHome
	CacheService cacheService
	
	new(AutoHome autoH,CacheService cs){
		this.autoHome = autoH
		this.cacheService = cs
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
	
	def private esMismaUbicacion(String u, Ubicacion u1){
		u.equals(u1.nombre)
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
	
	def List<Auto> buscarEnHibernate(){
		this.ejecutarBloque([|
			val List<Auto> autosRet = this.autoHome.obtenerAutos()
			autosRet
		]);
	}
	
	def obtenerAutosDisponibles(String origen,Date inicio,Date fin,Categoria cat) {
		//agregar la cache  verificar que nada rompa
			var List<Auto> autos = new ArrayList<Auto>
			var List<DisponibilidadAuto> autosDisponibles = this.cacheService.getAutosDisponiblesPorUbicacionYDia(origen,inicio,fin)
			System.out.println(autosDisponibles)
			//[null] me devuelve this.cacheService.getAutosDisponiblesPorUbicacionYDia
			if(autosDisponibles.size == 0){
				autos = this.buscarEnHibernate
			}else{
				autos = autosDisponibles.map[e| e.auto]
			}
			autos.filter[a | satisfaceFiltro(a,origen,inicio,fin,cat)] as List<Auto>
	}
	
	def satisfaceFiltro(Auto auto,String origen, Date inicio, Date fin, Categoria categoria) {
		var boolRes = true
		if(origen != null){
			boolRes = boolRes && esMismaUbicacion(origen,auto.ubicacionInicial)
		}
		if(inicio != null){
			boolRes = boolRes && tieneReservaDesdeInicio(auto,inicio)
		}
		if(fin != null){
			boolRes = boolRes && tieneReservaHastaFin(auto,fin)
		}
		if(categoria != null){
			boolRes = boolRes && tieneMismaCategoria(auto,categoria)
	}
		boolRes
	}
	
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