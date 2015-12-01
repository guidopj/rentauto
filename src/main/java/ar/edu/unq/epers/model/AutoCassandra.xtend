package ar.edu.unq.epers.model

import com.datastax.driver.mapping.annotations.UDT
import org.eclipse.xtend.lib.annotations.Accessors
import com.datastax.driver.mapping.annotations.Frozen

@UDT (keyspace = "cache", name = "auto")
@Accessors
class AutoCassandra {
	String marca
	String modelo
	Integer anio
	String patente
	Double costoBase
	@Frozen
	Categoria categoria
	
	new(String marca,String modelo,Integer ano,String patente,Double costoBase,Categoria categoria){
		this.marca = marca
		this.modelo = modelo
		this.anio = ano
		this.patente = patente
		this.costoBase = costoBase
		this.categoria = categoria
	}
}