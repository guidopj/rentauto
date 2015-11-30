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
	@PartitionKey
	Integer id
	@Frozen
	AutoCassandra auto
	Date dia
	
	new(Integer elId,AutoCassandra auto,Date dia){
		this.id = elId
		this.auto = auto
		this.dia = dia
	}
}