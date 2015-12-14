package ar.edu.unq.epers.model

import com.datastax.driver.mapping.annotations.Frozen;
import com.datastax.driver.mapping.annotations.PartitionKey;
import com.datastax.driver.mapping.annotations.Table;
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Date
import com.datastax.driver.mapping.annotations.ClusteringColumn

@Table(keyspace = "cache", name = "autosDisponibles")
@Accessors
class DisponibilidadAuto {
	//Como administrador quiero que la información de disponibilidad de los autos se guarde de forma cacheada por día 
	//y ubicación, o sea para cada día que autos estan disponibles. 
	//De esta manera es mucho más rápido la consultade los autos disponibles ese día
	
	
	/*
	 * Como administrador quiero que la información de disponibilidad de los autos se actualice en el caché 
	 * cuando ocurra un cambio.
	 * */
	
	
	int id
	@Frozen
	AutoCassandra auto
	Date fin
	Date inicio
	@PartitionKey(0)
	String ubicacion
	
	new(int id,AutoCassandra auto,Date inicio,Date fin,String ubicacion){
		this.id = id
		this.auto = auto
		this.inicio = inicio
		this.fin = fin
		this.ubicacion = ubicacion
	}
}