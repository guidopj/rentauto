package ar.edu.unq.epers.model

import org.junit.Before
import ar.edu.unq.epers.persistens.AutoHome
import org.junit.Test
import org.junit.Assert
import ar.edu.unq.epers.model.Auto
import java.util.Date
import java.util.List
import java.util.ArrayList
import ar.edu.unq.epers.services.RentAutoService
import org.junit.After
import ar.edu.unq.epers.sesiones.SessionManager
import org.hibernate.SessionFactory

class AutoService_Test {
	
	AutoHome autoH
	RentAutoService rentAutoS
	Empresa empresa
	
	Auto auto1
	Auto auto2
	Auto auto3
	Auto auto4
	Auto auto5
	
	@Before
	def void startUp(){
		autoH = new AutoHome
		rentAutoS = new RentAutoService(autoH)
		//autoS.anadirAuto("Fiat","Uno",1999,"ABC123",new Turismo(),new Double(1000),new Ubicacion("Retiro"))
		//autoS.anadirAuto("Fiat","Siena",2011,"ABR459",new Deportivo(),new Double(1000),new Ubicacion("Lanus"))
		//autoS.anadirAuto("Fiat","Punto",2015,"HTG205",new Familiar(),new Double(1000),new Ubicacion("Moron"))
		
		auto1 = new Auto("Fiat","Uno",1999,"ABC123",new Turismo(),new Double(1000),new Ubicacion("Retiro"))
		auto2 = new Auto("Fiat","Siena",2011,"ABR459",new Deportivo(),new Double(1000),new Ubicacion("Lanus"))
		auto3 = new Auto("Fiat","Punto",2015,"HTG205",new Familiar(),new Double(1000),new Ubicacion("Moron"))
		auto4 = new Auto("Fiat","Uno",1999,"CBW113",new Familiar(),new Double(1000),new Ubicacion("Munro"))
		auto5 = new Auto("Fiat","Punto",2013,"LBG204",new Deportivo(),new Double(1000),new Ubicacion("Quilmes"))
		
		var Reserva reserva1 = new Reserva(auto1,new Ubicacion("Lanus"),new Ubicacion("Retiro"),new Date(10,10,2015),new Date(11,10,2015))
		var Reserva reserva2 = new Reserva(auto2,new Ubicacion("La Paternal"),new Ubicacion("San Isidro"),new Date(10,12,2015),new Date(15,12,2015))
		var Reserva reserva3 = new Reserva(auto3,new Ubicacion("Berazategui"),new Ubicacion("Escalada"),new Date(20,12,2015),new Date(23,12,2015))
		
		auto1.reservas.add(reserva1)
		auto2.reservas.add(reserva2)
		auto3.reservas.add(reserva3)
		
		
		var List<Reserva> reservas = new ArrayList<Reserva>()
		reservas.add(reserva1)
		reservas.add(reserva2)
		reservas.add(reserva3)
		
		/*** **
		 * persisto la empresa y recursivamente las reservas, ubicaciones y autos
		 * */
		 
		//new(String cuit, String nombreEmpresa)
		empresa = new Empresa("50-43243252-3","Pepito Autos",reservas)
		rentAutoS.anadirEmpresa(empresa)
	}
	
	@Test
	def consultarFiatUno() {
		var Auto auto = rentAutoS.getAuto(1)
		Assert.assertEquals("ABC123", auto.patente);
	}
	
	/**
	 * Como usuario quiero saber los autos disponibles en una determinada ubicación un determinado día.
	*/
	
	@Test
	def testFiatUnoYFiatSienaDisponibles() {
		var Ubicacion ubicacion = new Ubicacion("Constitucion")
		var Date fecha = new Date()
		var List<Auto> autosDisponibles = rentAutoS.obtenerAutosDisponibles(ubicacion,fecha) as List<Auto>
		Assert.assertEquals("ABC123",autosDisponibles.get(0).patente );
		Assert.assertEquals("ABR459",autosDisponibles.get(1).patente );
		Assert.assertEquals(2,autosDisponibles.size);
	}
	
	
	/**
	 * Como usuario quiero que me devuelva la información de los autos posibles para la consulta de reserva, 
	 * entrando la siguiente información:
		Ubicación Origen
		Ubicación Destino
		Fecha Inicio
		Fecha Fin
		Categoria de auto deseado
	 * 
	 */
	 
	 //en que cambia ubicacion Destino?
	 @Test
	def testMostrarInfoPuntoLBG204() {
		var Ubicacion ubicacion = new Ubicacion("Quilmes")
		var Date fechaInicio = new Date()
		var Date fechaFin = new Date()
		var List<Auto> autosDisponibles = rentAutoS.obtenerAutosDisponiblesDe(new Ubicacion("Bernal"), new Ubicacion("Aeroparque"),new Date(),new Date(),new Turismo()) as List<Auto>
		Assert.assertEquals("ABC123",autosDisponibles.get(0).patente );
		Assert.assertEquals("ABR459",autosDisponibles.get(1).patente );
		Assert.assertEquals(2,autosDisponibles.size);
	}
	
	/**
	 * Como usuario quiero hacer una reserva.
	 */
	 
	@Test
	def void testRealizoReservaCorrectamente() {
		var Reserva reserva = new Reserva(auto3,new Ubicacion("Moron"),new Ubicacion("Marcos Paz"),new Date(10,12,2015),new Date(15,12,2015))
		rentAutoS.realizarReserva(reserva)
		empresa.agregarReserva(reserva)
		
	}
	
	//que tire alguna excepcion
//	@Test
//	def testNoHayAutosParaReserva() {
//		
//	}
	
	@After
	def void limpiar() {
		SessionManager.resetSessionFactory()
	}
}