package ar.edu.unq.epers.model

import ar.edu.unq.epers.extensions.DateExtensions
import ar.edu.unq.epers.persistens.CacheHome
import ar.edu.unq.epers.services.CacheService
import ar.edu.unq.epers.sesiones.CassandraSessionCreator
import com.datastax.driver.mapping.Mapper
import com.datastax.driver.mapping.MappingManager
import com.datastax.driver.mapping.UDTMapper
import java.util.HashMap
import java.util.Map
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.After
import org.junit.Before

import static ar.edu.unq.epers.sesiones.CassandraSessionCreator.*
import ar.edu.unq.epers.services.RentAutoService
import ar.edu.unq.epers.persistens.AutoHome

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
	RentAutoService rentAutoService
	AutoHome autoHome
	
	@Before
	def void startUp(){
		CassandraSessionCreator.crearKeySpace("cache")
		typeCategoria()
		//typeUbicacion()
		typeAuto()

		
		var Map<String,String> campos = new HashMap()
		campos.put("id","int")
		campos.put("auto","frozen<auto>")
		campos.put("inicio","timestamp")
		campos.put("fin","timestamp")
		campos.put("ubicacion","text")
		campos.put("PRIMARY KEY","(ubicacion,inicio)")

		CassandraSessionCreator.crearStruct("TABLE","cache","autosDisponibles",campos)
		
		////////////////
		
		cacheHome = new CacheHome()
		
		autoHome = new AutoHome()
		
		cacheService = new CacheService(cacheHome)
		
		rentAutoService = new RentAutoService(autoHome,cacheService)
		
		var Mapper<DisponibilidadAuto> dispMapper = new MappingManager(CassandraSessionCreator.cassandraSession).mapper(DisponibilidadAuto);
		var AutoCassandra auto1 = new AutoCassandra(333,"Fiat","Uno",1999,"ABC123",new Double(1000),new Turismo())
		var DisponibilidadAuto dispAuto = new DisponibilidadAuto(111,auto1,DateExtensions.nuevaFecha(2015,11,30),DateExtensions.nuevaFecha(2015,12,01),"Moron")
		
		var AutoCassandra auto2 = new AutoCassandra(555,"Fiat","Siena",2007,"ABC125",new Double(1000),new Turismo())
		var DisponibilidadAuto dispAuto2 = new DisponibilidadAuto(222,auto2,DateExtensions.nuevaFecha(2015,12,01),DateExtensions.nuevaFecha(2015,12,03),"Berazategui")
		
		dispMapper.save(dispAuto)
		dispMapper.save(dispAuto2)
	}
	
	@After
	def void clearDatabase(){
		CassandraSessionCreator.eliminarKeyspace("cache")
		CassandraSessionCreator.cassandraSession.close()
		CassandraSessionCreator.cluster.close()
		CassandraSessionCreator.cluster = null
	}
	
	
}