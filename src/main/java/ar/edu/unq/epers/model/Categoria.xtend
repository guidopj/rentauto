package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors
import com.datastax.driver.mapping.annotations.UDT

@UDT (keyspace = "cache", name = "categoria")
@Accessors
abstract class Categoria {
	int id_Categoria
	String nombre
	
	new(){}
	
	abstract def Double calcularCosto(Auto auto)
}


class Turismo extends Categoria{
	
	new() {
		this.nombre = "Turismo"
	}
	
	override calcularCosto(Auto auto) {
		if(auto.anio > 2000){
			return auto.costoBase * 1.10			
		}else{
			return auto.costoBase - 200
		}
	}
}

class Familiar extends Categoria{
	
	new() {
		this.nombre = "Familiar"
	}
	
	override calcularCosto(Auto auto) {
		return auto.costoBase + 200
	}
}

class Deportivo extends Categoria{
	
	new() {
		this.nombre = "Deportivo"
	}
	
	override calcularCosto(Auto auto) {
		if(auto.anio > 2000){
			return auto.costoBase * 1.30			
		}else{
			return auto.costoBase * 1.20
		}
	}
}

class TodoTerreno extends Categoria{
	
	new() {
		this.nombre = "TodoTerreno"
	}
	
	override calcularCosto(Auto auto) {
		auto.costoBase * 1.10
	}
}
