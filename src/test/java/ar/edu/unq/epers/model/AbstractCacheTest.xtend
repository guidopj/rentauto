package ar.edu.unq.epers.model

import org.junit.After
import org.junit.Before
import ar.edu.unq.epers.sesiones.CassandraSessionCreator
import java.util.HashMap
import java.util.Map
import ar.edu.unq.epers.services.CacheService
import ar.edu.unq.epers.persistens.CacheHome
import com.datastax.driver.mapping.MappingManager
import com.datastax.driver.mapping.Mapper
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.extensions.DateExtensions

@Accessors
class AbstractCacheTest {
	
	def void typeAuto(){
		var Map<String,String> camposAuto = new HashMap()
		camposAuto.put("id","int")
		camposAuto.put("marca","text")
		camposAuto.put("modelo","text")
		camposAuto.put("anio","int")
		camposAuto.put("patente","text")
		camposAuto.put("costoBase","double")
		camposAuto.put("categoria","frozen<categoria>")
		camposAuto.put("ubicacion","text")
		
		CassandraSessionCreator.crearStruct("TYPE","cache","auto",camposAuto)
	}
	
	def void typeCategoria(){
		var Map<String,String> camposCategoria = new HashMap()
		camposCategoria.put("id_Categoria","int")
		camposCategoria.put("nombre","text")
		
		CassandraSessionCreator.crearStruct("TYPE","cache","categoria",camposCategoria)
	}
	
//	def void typeUbicacion(){
//		var Map<String,String> camposUbicaciones = new HashMap()
//		camposUbicaciones.put("id_ubicacion","int")
//		camposUbicaciones.put("nombre","text")
//		
//		CassandraSessionCreator.crearStruct("TYPE","cache","ubicacion",camposUbicaciones)
//	}
	
	
	CacheService cacheService
	CacheHome cacheHome
	
	@Before
	def void startUp(){
		CassandraSessionCreator.crearKeySpace("cache")
		typeCategoria()
		//typeUbicacion()
		typeAuto()

		
		var Map<String,String> campos = new HashMap()
		campos.put("id","int")
		campos.put("auto","frozen<auto>")
		campos.put("dia","timestamp")
		campos.put("ubicacion","text")
		campos.put("PRIMARY KEY","(ubicacion,dia,id)"
		 );

		CassandraSessionCreator.crearStruct("TABLE","cache","autosDisponibles",campos)
		
		cacheHome = new CacheHome()
		
		cacheService = new CacheService(cacheHome)
		
		
		
		//////
		
		
		var Mapper<DisponibilidadAuto> dispMapper = new MappingManager(CassandraSessionCreator.cassandraSession).mapper(DisponibilidadAuto);
		var AutoCassandra auto1 = new AutoCassandra(111,"Fiat","Uno",1999,"ABC123",new Double(1000),new Turismo(),"Moron")
		var DisponibilidadAuto dispAuto = new DisponibilidadAuto(111,auto1,DateExtensions.nuevaFecha(2015,11,30))
		
		var AutoCassandra auto2 = new AutoCassandra(111,"Fiat","Siena",2007,"ABC125",new Double(1000),new Turismo(),"Berazategui")
		var DisponibilidadAuto dispAuto2 = new DisponibilidadAuto(113,auto2,DateExtensions.nuevaFecha(2015,12,01))
		
		dispMapper.save(dispAuto)
		dispMapper.save(dispAuto2)
	}
	
	@After
	def void clearDatabase(){
		CassandraSessionCreator.eliminarKeyspace("cache")
		CassandraSessionCreator.cassandraSession.close()
		CassandraSessionCreator.cluster.close()
	}
	
	
}