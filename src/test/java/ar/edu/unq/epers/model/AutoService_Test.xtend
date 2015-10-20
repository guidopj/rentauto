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
import static ar.edu.unq.epers.extensions.DateExtensions.*

class AutoService_Test{
	
	IUsuario usuario1
	AutoHome autoH
	RentAutoService rentAutoS
	Empresa empresa
	
	Auto auto1
	Auto auto2
	Auto auto3
	Auto auto4
	Auto auto5
	
	Ubicacion ubicacionMoron
	Ubicacion ubicacionRetiro
	Ubicacion ubicacionMunro
	Ubicacion ubicacionBerazategui
	Ubicacion ubicacionLanus
	Ubicacion ubicacionLaPaternal
	Ubicacion ubicacionSanIsidro
	Ubicacion ubicacionEscalada
	Ubicacion ubicacionBanfield
	Ubicacion ubicacionMarcos_Paz
	
	@Before
	def void startUp(){
		autoH = new AutoHome
		rentAutoS = new RentAutoService(autoH)
		usuario1 = new Usuario()
		
		ubicacionMoron = new Ubicacion("Moron")
		ubicacionRetiro = new Ubicacion("Retiro")
		ubicacionBanfield = new Ubicacion("Banfield")
		ubicacionBerazategui = new Ubicacion("Berazategui")
		ubicacionLanus = new Ubicacion("Lanus")
		ubicacionLaPaternal = new Ubicacion("La Paternal")
		ubicacionSanIsidro = new Ubicacion("San Isidro")
		ubicacionEscalada = new Ubicacion("Escalada")
		ubicacionMunro = new Ubicacion("Munro")
		ubicacionMarcos_Paz = new Ubicacion("Marcos Paz")
		
		auto1 = new Auto("Fiat","Uno",1999,"ABC123",new Turismo(),new Double(1000),ubicacionRetiro)
		auto2 = new Auto("Fiat","Siena",2011,"ABR459",new Deportivo(),new Double(1000),ubicacionRetiro)
		auto3 = new Auto("Fiat","Punto",2015,"HTG205",new Familiar(),new Double(1000),ubicacionMoron)
		auto4 = new Auto("Fiat","Punto",2011,"RTF295",new Familiar(),new Double(1000),ubicacionBerazategui)
		auto5 = new Auto("Fiat","Uno",1999,"CBW113",new Familiar(),new Double(1000),ubicacionMoron)
		var Reserva reserva1 = new Reserva(100,auto1,ubicacionLanus,ubicacionRetiro,nuevaFecha(2015,12,10),nuevaFecha(2015,12,12),usuario1)
		var Reserva reserva2 = new Reserva(101,auto2,ubicacionLaPaternal,ubicacionSanIsidro,nuevaFecha(2015,12,10),nuevaFecha(2015,12,15),usuario1)
		var Reserva reserva3 = new Reserva(102,auto3,ubicacionMunro,ubicacionEscalada,nuevaFecha(2015,12,20),nuevaFecha(2015,12,23),usuario1)
		var Reserva reserva4 = new Reserva(103,auto4,ubicacionBerazategui,ubicacionEscalada ,nuevaFecha(2015,12,20),nuevaFecha(2015,12,23),usuario1)
		
		auto1.reservas.add(reserva1)
		auto2.reservas.add(reserva2)
		auto3.reservas.add(reserva3)
		auto4.reservas.add(reserva4)
		
		
		var List<Reserva> reservas = new ArrayList<Reserva>()
		reservas.add(reserva1)
		reservas.add(reserva2)
		reservas.add(reserva3)
		reservas.add(reserva4)
		
		/*** **
		 * persisto la empresa y recursivamente las reservas, ubicaciones y autos
		 * */
		
		//this.usuarios.contains(unaReserva.usuario) EMPRESA
		empresa = new Empresa("50-43243252-3","Pepito Autos",reservas)
		rentAutoS.anadir(empresa)
	}
	
	@Test
	def void anadirFiatPunto2013() {
		var auto5 = new Auto("Fiat","Punto",2013,"LBG204",new Deportivo(),new Double(1000),new Ubicacion(""))
		rentAutoS.anadir(auto5)
	}
	
	@Test
	def void testObtenerTotalAutos(){
		
		var List<Auto> totalAutos = rentAutoS.obtenerTotalAutos
		Assert.assertEquals(4,totalAutos.size)
	}
	
	/**
	 * Como usuario quiero saber los autos disponibles en una determinada ubicación un determinado día.
	*/
	
	@Test
	def testFiatUnoYFiatSienaDisponibles() {
		var Ubicacion ubicacionInicial = ubicacionRetiro
		var Date fechaInicio =  nuevaFecha(2015,12,8)
		var List<Auto> autosDisponibles = rentAutoS.obtenerAutosDisponibles(ubicacionInicial,fechaInicio,null,null)
		Assert.assertEquals("ABC123",autosDisponibles.get(0).patente );
		Assert.assertEquals("ABR459",autosDisponibles.get(1).patente );
		Assert.assertEquals(2,autosDisponibles.size);
	}
	
	
	@Test
	def testNoHayDisponiblesEnMoronEnFecha() {
		var Ubicacion ubicacionInicial = ubicacionMoron
		var Date fechaInicio = nuevaFecha(2015,12,21)
		var List<Auto> autosDisponibles = rentAutoS.obtenerAutosDisponibles(ubicacionInicial,fechaInicio,null,null)
		Assert.assertEquals(0,autosDisponibles.size);
	}
	
	@Test
	def testSoloFiatPuntoDisponible() {
		var Ubicacion ubicacionInicial = ubicacionBerazategui
		var Date fechaInicio = nuevaFecha(2015,12,19)
		var List<Auto> autosDisponibles = rentAutoS.obtenerAutosDisponibles(ubicacionInicial,fechaInicio,null,null)
		Assert.assertEquals(1,autosDisponibles.size);
	}
	
	@Test
	def testNoHayDisponiblesEnUbicacion() {
		var Ubicacion ubicacionInicial = ubicacionLanus
		var Date fechaInicio = nuevaFecha(2015,11,10)
		var List<Auto> autosDisponibles = rentAutoS.obtenerAutosDisponibles(ubicacionInicial,fechaInicio,null,null)
		Assert.assertEquals(0,autosDisponibles.size);
	}
	
	@Test
	def testTotalAutosFamiliares() {
		rentAutoS.anadir(auto5)
		var List<Auto> autosDisponibles = rentAutoS.obtenerAutosDisponibles(null,null,null,new Familiar())
		Assert.assertEquals(3,autosDisponibles.size);
	}
	
	/**
	 * Como usuario quiero hacer una reserva.
	 */
	 
	@Test
	def void testRealizoReservaCorrectamente() {
		var Reserva reserva = new Reserva(110,auto5,ubicacionMoron,ubicacionMarcos_Paz,nuevaFecha(2015,12,10),nuevaFecha(2015,12,15),usuario1)
		empresa.usuarios.add(usuario1)
		empresa.agregarReserva(reserva)
		rentAutoS.realizarReserva(reserva)
		
		Assert.assertEquals(1,rentAutoS.obtenerReservaPorNumeroSolicitud(110).size)
		
	}
	
	@Test(expected=ReservaException)
	def void testUsuarioNoPerteneceAEmpresa() {
		var Reserva reserva = new Reserva(111,auto5,ubicacionMoron,ubicacionBerazategui,nuevaFecha(2015,10,10),nuevaFecha(2015,10,11),usuario1)
		empresa.agregarReserva(reserva)
		rentAutoS.realizarReserva(reserva)
	}
	
	@After
	def void limpiar() {
		SessionManager.resetSessionFactory()
	}
}