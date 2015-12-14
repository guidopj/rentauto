package ar.edu.unq.epers.model

import ar.edu.unq.epers.extensions.DateExtensions
import java.util.List
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
}