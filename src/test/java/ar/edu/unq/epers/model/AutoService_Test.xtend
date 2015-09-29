package ar.edu.unq.epers.model

import org.junit.Before
import ar.edu.unq.epers.services.AutoService
import ar.edu.unq.epers.persistens.AutoHome
import org.junit.Test
import org.junit.Assert
import ar.edu.unq.epers.model.Auto

class AutoService_Test {
	
	AutoHome autoH
	AutoService autoS
	
	@Before
	def void startUp(){
		autoH = new AutoHome
		autoS = new AutoService(autoH)
		autoS.anadirAuto("Fiat","Uno",1999,"ABC123",new Turismo(),new Double(1000),new Ubicacion("Retiro"))
	}
	
	@Test
	def consultarFiatUno() {
		var Auto auto = autoS.getAuto(1)
		Assert.assertEquals("ABC123", auto.patente);
	}
	
}