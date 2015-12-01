package ar.edu.unq.epers.persistens

import java.util.Date
import com.datastax.driver.core.Statement
import com.datastax.driver.core.querybuilder.QueryBuilder
import com.datastax.driver.core.ResultSet
import ar.edu.unq.epers.sesiones.CassandraSessionCreator
import com.datastax.driver.core.Row
import ar.edu.unq.epers.model.Ubicacion

class CacheHome {
	
	def obtenerAutosPorUbicacionYDia(String ubi,Date dia){
		var Statement statement = QueryBuilder.select()
        .all()
        .from("cache", "autosDisponibles")
        .where(QueryBuilder.eq("ubicacion",ubi)).and(QueryBuilder.eq("dia",dia));
        
		return CassandraSessionCreator.cacheSession.execute(statement);
		
//		for ( Row row : results ) {
//    		System.out.println("Song: " + row.getString("artist"));
//		}
	}
	
	def obtenerAutosPorUbicacionYDiaInicioDiaFin(String ubi,Date diaInicio,Date diaFin){
		var Statement statement = QueryBuilder.select()
        .all()
        .from("cache", "autosDisponibles")
        .where(QueryBuilder.eq("ubicacion",ubi)).and(QueryBuilder.gt("dia",diaInicio)).and(QueryBuilder.lt("dia",diaFin));
        
		return CassandraSessionCreator.cacheSession.execute(statement);
		
	}
}