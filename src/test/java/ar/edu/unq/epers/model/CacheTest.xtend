package ar.edu.unq.epers.model

import org.junit.Test
import com.datastax.driver.core.ResultSet
import org.junit.Assert
import ar.edu.unq.epers.extensions.DateExtensions

class CacheTest extends AbstractCacheTest{
	
	
	@Test
	def void accederAutosDeHoyPorDia(){
		var ResultSet rs = cacheService.getAutosDisponiblesPorFecha(DateExtensions.nuevaFecha(2015,11,30))
		Assert.assertEquals(1,rs.size)
	}
	
	@Test
	def void accederAutosDeHoyPorUbicacionBerazategui(){
		var ResultSet rs = cacheService.getAutosDisponiblesPorUbicacion("Berazategui")
		Assert.assertEquals(1,rs.size)
	}
	
	
}