package ar.edu.unq.epers.model

import com.datastax.driver.mapping.annotations.Frozen
import com.datastax.driver.mapping.annotations.PartitionKey
import com.datastax.driver.mapping.annotations.UDT
import org.eclipse.xtend.lib.annotations.Accessors

@UDT (keyspace = "cache", name = "auto")
@Accessors
class AutoCassandra extends Auto{
	int id
	@Frozen
	Categoria categoria
	
	new(int id,String marca,String modelo,Integer ano,String patente,Double costoBase,Categoria categoria){
		super(marca,modelo,ano,patente,costoBase)
		this.id = id
		this.categoria = categoria
	}
}