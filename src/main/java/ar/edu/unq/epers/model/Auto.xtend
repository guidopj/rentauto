package ar.edu.unq.epers.model

import java.util.Date
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import com.datastax.driver.mapping.annotations.UDT

@Accessors
//@UDT (keyspace = "cache", name = "auto")
class Auto {
	int id
	String marca
	String modelo
	Integer anio
	String patente
	Double costoBase
	Categoria categoria
	
	//Debe estar ordenado
	List<Reserva> reservas = newArrayList()
	Ubicacion ubicacionInicial
	
	new(String marca, String modelo, Integer anio, String patente, Categoria categoria,Double costoBase, Ubicacion ubicacionInicial){
		this.marca = marca
		this.modelo = modelo
		this.anio = anio
		this.categoria = categoria
		this.patente = patente
		this.costoBase = costoBase
		this.ubicacionInicial = ubicacionInicial
	}
	
	new(String marca, String modelo, Integer anio, String patente, Double costoBase){
		this.marca = marca
		this.modelo = modelo
		this.anio = anio
		this.patente = patente
		this.costoBase = costoBase
	}
	
	new(){}

	def getUbicacionInicial(){
		this.ubicacionParaDia(new Date());
	}
	
	def ubicacionParaDia(Date unDia){
		val encontrado = reservas.findLast[ it.fin <= unDia ]
		if(encontrado != null){
			return encontrado.destino
		}else{
			return ubicacionInicial
		}
	}
	
	def Boolean estaLibre(Date desde, Date hasta){
		reservas.forall[ !seSuperpone(desde,hasta) ]
	}
	
	def agregarReserva(Reserva reserva){
		reserva.validar
		reservas.add(reserva)
		reservas.sortInplaceBy[inicio]
	}
	
	def costoTotal(){
		return categoria.calcularCosto(this)
	}
	
}
