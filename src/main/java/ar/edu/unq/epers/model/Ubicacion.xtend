package ar.edu.unq.epers.model

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import com.datastax.driver.mapping.annotations.UDT

@UDT (keyspace = "cache", name = "ubicacion")
@Accessors 
class Ubicacion {
	int id_ubicacion
	String nombre
	
	new(){}
	
	new(String nombre){
		this.nombre = nombre
	}
}

@Accessors 
class UbicacionVirtual extends Ubicacion{
	List<Ubicacion> ubicaciones
}
