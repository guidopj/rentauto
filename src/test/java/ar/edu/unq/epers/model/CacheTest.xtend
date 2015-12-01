package ar.edu.unq.epers.model

import org.junit.Test
import com.datastax.driver.core.ResultSet
import org.junit.Assert
import ar.edu.unq.epers.extensions.DateExtensions

class CacheTest extends AbstractCacheTest{
	
	
	@Test
	def void accederAutosDeHoyPorUbicacionBerazategui(){
		var ResultSet rs = cacheService.getAutosDisponiblesPorUbicacionYDia("Berazategui",DateExtensions.nuevaFecha(2015,12,01))
		Assert.assertEquals(1,rs.size)
	}
	
	@Test
	def void accederAutosDeMananaPorUbicacionBerazategui(){
		var ResultSet rs = cacheService.getAutosDisponiblesPorUbicacionYDia("Berazategui",DateExtensions.nuevaFecha(2015,12,02))
		Assert.assertEquals(0,rs.size)
	}
	
	@Test
	def void accederAutosDeHoyPorUbicacionRetiro(){
		var ResultSet rs = cacheService.getAutosDisponiblesPorUbicacionYDia("Retiro",DateExtensions.nuevaFecha(2015,12,01))
		Assert.assertEquals(0,rs.size)
	}
	
	
	
}