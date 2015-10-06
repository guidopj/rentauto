package ar.edu.unq.epers.services

import ar.edu.unq.epers.persistens.AutoHome
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.sesiones.SessionManager
import ar.edu.unq.epers.model.Ubicacion
import java.util.Date
import ar.edu.unq.epers.model.Empresa
import ar.edu.unq.epers.model.Reserva
import java.util.List
import ar.edu.unq.epers.model.Auto
import java.util.ArrayList
import ar.edu.unq.epers.model.Categoria

@Accessors
class RentAutoService {
	
	AutoHome autoHome
	
	new(AutoHome autoH){
		this.autoHome = autoH
	}
	
//	def anadirAuto(String marca, String modelo, Integer anio, String patente, Categoria categoria,Double costoBase, Ubicacion ubicacionInicial){
//		SessionManager.runInSession([
//			val Auto auto = new Auto(marca, modelo, anio, patente,categoria,costoBase,ubicacionInicial);
//			this.autoHome.guardarAuto(auto);
//		]);
//	}

	def anadirEmpresa(Empresa empresa){
		SessionManager.runInSession([
			this.autoHome.guardar(empresa);
		]);
	}
	
	def getAuto(int id){
		SessionManager.runInSession([
			this.autoHome.obtenerAuto(id);
		]);
	}
	
	def private esMismaUbicacion(Ubicacion u, Ubicacion u1){
		u.nombre.equals(u1.nombre)
	}
	
	def private tieneReservaEn(Auto a, Date fecha){
		for(Reserva r : a.reservas){
			if(r.inicio.before(fecha) && r.fin.after(fecha)){
				return true
			}
		}
		false
	}
	
	def obtenerAutosDisponibles(Ubicacion ubicacion, Date fecha) {
		SessionManager.runInSession([
			var List<Auto> autosDisponibles = new ArrayList<Auto>
			var List<Auto> autos = this.autoHome.obtenerAutos(ubicacion,fecha)
			for(Auto a : autos){
				if(esMismaUbicacion(a.ubicacionInicial,ubicacion) && !tieneReservaEn(a,fecha)){
					autosDisponibles.add(a)
				}
			}
			autosDisponibles
		]);
	}
	
	def obtenerAutosDisponiblesDe(Ubicacion ubicacionOrigen, Ubicacion ubicacionDestino,Date fecha,Date fin,Categoria categoria) {
		SessionManager.runInSession([
			var List<Auto> autosDisponibles = new ArrayList<Auto>
			var List<Auto> autos = this.autoHome.obtenerAutos(ubicacionOrigen,fecha)
			for(Auto a : autos){
				if(esMismaUbicacion(a.ubicacionInicial,ubicacionOrigen) && !tieneReservaEn(a,fecha)){
					autosDisponibles.add(a)
				}
			}
			autosDisponibles as List<Auto>
		]);
	}
	
	def realizarReserva(Reserva reservaNueva) {
		//Auto auto,Ubicacion origen,Ubicacion destino,Date inicio,Date fin
		reservaNueva.reservar()
		this.autoHome.guardar(reservaNueva)
	}
	
}