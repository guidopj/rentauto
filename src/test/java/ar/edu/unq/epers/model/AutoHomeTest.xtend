package ar.edu.unq.epers.model

import ar.edu.unq.epers.persistens.AutoHome
import org.junit.Before
import ar.edu.unq.epers.services.RentAutoService
import java.util.List
import org.junit.Assert
import org.junit.Test

class AutoHomeTest {
	AutoHome autoHome
	Auto auto1
	Auto auto2
	Auto auto3
	
	
	@Before
	def void startUp(){
		autoHome = new AutoHome
		var rentAutoS = new RentAutoService(autoHome)
		auto1 = new Auto("Fiat","Uno",1999,"ABC123",new Turismo(),new Double(1000),new Ubicacion("Retiro"))
		auto2 = new Auto("Fiat","Siena",2011,"ABR459",new Deportivo(),new Double(1000),new Ubicacion("Lanus"))
		auto3 = new Auto("Fiat","Punto",2015,"HTG205",new Familiar(),new Double(1000),new Ubicacion("Moron"))
		
		rentAutoS.anadir(auto1)
		rentAutoS.anadir(auto2)
		rentAutoS.anadir(auto3)
			
	}
}