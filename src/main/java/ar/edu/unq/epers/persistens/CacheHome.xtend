package ar.edu.unq.epers.persistens

import ar.edu.unq.epers.extensions.DateExtensions
import ar.edu.unq.epers.model.AutoCassandra
import ar.edu.unq.epers.model.DisponibilidadAuto
import ar.edu.unq.epers.sesiones.CassandraSessionCreator
import com.datastax.driver.core.ResultSet
import com.datastax.driver.core.Row
import com.datastax.driver.core.Statement
import com.datastax.driver.core.querybuilder.QueryBuilder
import com.datastax.driver.mapping.Mapper
import com.datastax.driver.mapping.MappingManager
import java.util.ArrayList
import java.util.Date
import java.util.List

//		for ( Row row : results ) {
//    		System.out.println("Song: " + row.getString("artist"));
//		}

class CacheHome {
	
	def  obtenerAutosPorUbicacionYDia(String ubi,Date inicio,Date fin){
		var List<DisponibilidadAuto> dispAutos = new ArrayList<DisponibilidadAuto>
		var Statement statement = QueryBuilder.select()
        .all()
        .from("cache", "autosDisponibles")
        .where(QueryBuilder.eq("ubicacion",ubi)).and(QueryBuilder.gte("inicio",inicio))
        
		var ResultSet rs = CassandraSessionCreator.cacheSession.execute(statement);
		var Mapper<DisponibilidadAuto> mapper = new MappingManager(CassandraSessionCreator.cacheSession).mapper(DisponibilidadAuto);
		for(Row row : rs){
			System.out.println(row.getInt("id"))
			//el print devuelve 222 correctamente
 			var DisponibilidadAuto autoC = mapper.get(row.getInt("id").toString);
			dispAutos.add(autoC)
		}
		dispAutos
	}
	
		def agregarDisponibilidad(AutoCassandra auto,Date inicio,Date fin,String ubicacion){
			var Mapper<DisponibilidadAuto> dispMapper = new MappingManager(CassandraSessionCreator.cassandraSession).mapper(DisponibilidadAuto);
			var DisponibilidadAuto dispAuto = new DisponibilidadAuto(111,auto,inicio,fin,ubicacion)
			dispMapper.save(dispAuto)
		}
		
		def eliminarDisponibilidad(int idDisp){
			var Mapper<DisponibilidadAuto> dispMapper = new MappingManager(CassandraSessionCreator.cassandraSession).mapper(DisponibilidadAuto);
			dispMapper.delete(idDisp);
		}
}