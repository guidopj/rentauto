package ar.edu.unq.epers.model

import com.datastax.driver.mapping.annotations.Frozen;
import com.datastax.driver.mapping.annotations.PartitionKey;
import com.datastax.driver.mapping.annotations.Table;
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.Date

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
	 
	@Frozen
	AutoCassandra auto
	@PartitionKey(1)
	Date dia
	@PartitionKey(0)
	String ubicacion
	
	new(AutoCassandra auto,Date dia,String ubicacion){
		this.auto = auto
		this.dia = dia
		this.ubicacion = ubicacion
	}
}