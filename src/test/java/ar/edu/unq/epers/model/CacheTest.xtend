package ar.edu.unq.epers.model

import ar.edu.unq.epers.extensions.DateExtensions
import java.util.List
import java.util.Random
import org.junit.Assert
import org.junit.Test

class CacheTest extends AbstractCacheTest{
	
	
	@Test
	def void accederAutosDeHoyPorUbicacionBerazategui(){
		var List<DisponibilidadAuto> rs = cacheService.getAutosDisponiblesPorUbicacionYDia("Berazategui",DateExtensions.nuevaFecha(2015,12,01),DateExtensions.nuevaFecha(2015,12,01))
		Assert.assertEquals(1,rs.size)
	}
	
	@Test
	def void accederAutosDeMananaPorUbicacionBerazategui(){
		var List<DisponibilidadAuto> rs = cacheService.getAutosDisponiblesPorUbicacionYDia("Berazategui",DateExtensions.nuevaFecha(2015,12,02),DateExtensions.nuevaFecha(2015,12,02))
		Assert.assertEquals(0,rs.size)
	}
	
	@Test
	def void accederAutosDeHoyPorUbicacionRetiro(){
		var List<DisponibilidadAuto> rs = cacheService.getAutosDisponiblesPorUbicacionYDia("Retiro",DateExtensions.nuevaFecha(2015,12,01),DateExtensions.nuevaFecha(2015,12,01))
		Assert.assertEquals(0,rs.size)
	}
	
	@Test
	def void agregarDisponibilidad(){
		var Random r = new Random()
		var AutoCassandra auto = new AutoCassandra(r.nextInt,"Ford","Ka",2004,"GRE009",new Double(1055),new Turismo())
		cacheService.agregarDisponibilidad(auto,DateExtensions.nuevaFecha(2015,12,07),DateExtensions.nuevaFecha(2015,12,10),"La Matanza")
		
		var List<DisponibilidadAuto> rs = cacheService.getAutosDisponiblesPorUbicacionYDia("La Matanza",DateExtensions.nuevaFecha(2015,12,07),DateExtensions.nuevaFecha(2015,12,9))
		Assert.assertEquals(1,rs.size)
	}
	
	@Test
	def void realizarReserva(){
		
		/*
		 * java.lang.ClassCastException: com.google.common.collect.Iterables$6 cannot be cast to java.util.List
		*/
		var autosDis = rentAutoService.obtenerAutosDisponibles("Berazategui",DateExtensions.nuevaFecha(2015,12,01),DateExtensions.nuevaFecha(2015,12,01),new Turismo)
		System.out.println(autosDis)
		Assert.assertEquals(1,autosDis.size)
	}
	
	
}