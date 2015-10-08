package ar.edu.unq.epers.model;

import ar.edu.unq.epers.extensions.DateExtensions;
import ar.edu.unq.epers.model.Auto;
import ar.edu.unq.epers.model.Deportivo;
import ar.edu.unq.epers.model.Empresa;
import ar.edu.unq.epers.model.Familiar;
import ar.edu.unq.epers.model.IUsuario;
import ar.edu.unq.epers.model.Reserva;
import ar.edu.unq.epers.model.ReservaException;
import ar.edu.unq.epers.model.Turismo;
import ar.edu.unq.epers.model.Ubicacion;
import ar.edu.unq.epers.model.Usuario;
import ar.edu.unq.epers.persistens.AutoHome;
import ar.edu.unq.epers.services.RentAutoService;
import ar.edu.unq.epers.sesiones.SessionManager;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

@SuppressWarnings("all")
public class AutoService_Test {
  private IUsuario usuario1;
  
  private AutoHome autoH;
  
  private RentAutoService rentAutoS;
  
  private Empresa empresa;
  
  private Auto auto1;
  
  private Auto auto2;
  
  private Auto auto3;
  
  private Auto auto4;
  
  private Auto auto5;
  
  private Ubicacion ubicacionMoron;
  
  private Ubicacion ubicacionRetiro;
  
  private Ubicacion ubicacionMunro;
  
  private Ubicacion ubicacionBerazategui;
  
  private Ubicacion ubicacionQuilmes;
  
  private Ubicacion ubicacionLanus;
  
  private Ubicacion ubicacionLaPaternal;
  
  private Ubicacion ubicacionSanIsidro;
  
  private Ubicacion ubicacionEscalada;
  
  private Ubicacion ubicacionBanfield;
  
  private Ubicacion ubicacionMarcos_Paz;
  
  @Before
  public void startUp() {
    AutoHome _autoHome = new AutoHome();
    this.autoH = _autoHome;
    RentAutoService _rentAutoService = new RentAutoService(this.autoH);
    this.rentAutoS = _rentAutoService;
    Usuario _usuario = new Usuario();
    this.usuario1 = _usuario;
    Ubicacion _ubicacion = new Ubicacion("Moron");
    this.ubicacionMoron = _ubicacion;
    Ubicacion _ubicacion_1 = new Ubicacion("Retiro");
    this.ubicacionRetiro = _ubicacion_1;
    Ubicacion _ubicacion_2 = new Ubicacion("Banfield");
    this.ubicacionBanfield = _ubicacion_2;
    Ubicacion _ubicacion_3 = new Ubicacion("Berazategui");
    this.ubicacionBerazategui = _ubicacion_3;
    Ubicacion _ubicacion_4 = new Ubicacion("Lanus");
    this.ubicacionLanus = _ubicacion_4;
    Ubicacion _ubicacion_5 = new Ubicacion("La Paternal");
    this.ubicacionLaPaternal = _ubicacion_5;
    Ubicacion _ubicacion_6 = new Ubicacion("San Isidro");
    this.ubicacionSanIsidro = _ubicacion_6;
    Ubicacion _ubicacion_7 = new Ubicacion("Escalada");
    this.ubicacionEscalada = _ubicacion_7;
    Ubicacion _ubicacion_8 = new Ubicacion("Munro");
    this.ubicacionMunro = _ubicacion_8;
    Ubicacion _ubicacion_9 = new Ubicacion("Marcos Paz");
    this.ubicacionMarcos_Paz = _ubicacion_9;
    Turismo _turismo = new Turismo();
    Double _double = new Double(1000);
    Auto _auto = new Auto("Fiat", "Uno", Integer.valueOf(1999), "ABC123", _turismo, _double, this.ubicacionRetiro);
    this.auto1 = _auto;
    Deportivo _deportivo = new Deportivo();
    Double _double_1 = new Double(1000);
    Auto _auto_1 = new Auto("Fiat", "Siena", Integer.valueOf(2011), "ABR459", _deportivo, _double_1, this.ubicacionRetiro);
    this.auto2 = _auto_1;
    Familiar _familiar = new Familiar();
    Double _double_2 = new Double(1000);
    Auto _auto_2 = new Auto("Fiat", "Punto", Integer.valueOf(2015), "HTG205", _familiar, _double_2, this.ubicacionMoron);
    this.auto3 = _auto_2;
    Familiar _familiar_1 = new Familiar();
    Double _double_3 = new Double(1000);
    Auto _auto_3 = new Auto("Fiat", "Punto", Integer.valueOf(2011), "RTF295", _familiar_1, _double_3, this.ubicacionBerazategui);
    this.auto4 = _auto_3;
    Familiar _familiar_2 = new Familiar();
    Double _double_4 = new Double(1000);
    Auto _auto_4 = new Auto("Fiat", "Uno", Integer.valueOf(1999), "CBW113", _familiar_2, _double_4, this.ubicacionMoron);
    this.auto5 = _auto_4;
    Date _nuevaFecha = DateExtensions.nuevaFecha(2015, 12, 10);
    Date _nuevaFecha_1 = DateExtensions.nuevaFecha(2015, 12, 12);
    Reserva reserva1 = new Reserva(this.auto1, this.ubicacionLanus, this.ubicacionRetiro, _nuevaFecha, _nuevaFecha_1, this.usuario1);
    Date _nuevaFecha_2 = DateExtensions.nuevaFecha(2015, 12, 10);
    Date _nuevaFecha_3 = DateExtensions.nuevaFecha(2015, 12, 15);
    Reserva reserva2 = new Reserva(this.auto2, this.ubicacionLaPaternal, this.ubicacionSanIsidro, _nuevaFecha_2, _nuevaFecha_3, this.usuario1);
    Date _nuevaFecha_4 = DateExtensions.nuevaFecha(2015, 12, 20);
    Date _nuevaFecha_5 = DateExtensions.nuevaFecha(2015, 12, 23);
    Reserva reserva3 = new Reserva(this.auto3, this.ubicacionMunro, this.ubicacionEscalada, _nuevaFecha_4, _nuevaFecha_5, this.usuario1);
    Date _nuevaFecha_6 = DateExtensions.nuevaFecha(2015, 12, 20);
    Date _nuevaFecha_7 = DateExtensions.nuevaFecha(2015, 12, 23);
    Reserva reserva4 = new Reserva(this.auto4, this.ubicacionBerazategui, this.ubicacionEscalada, _nuevaFecha_6, _nuevaFecha_7, this.usuario1);
    List<Reserva> _reservas = this.auto1.getReservas();
    _reservas.add(reserva1);
    List<Reserva> _reservas_1 = this.auto2.getReservas();
    _reservas_1.add(reserva2);
    List<Reserva> _reservas_2 = this.auto3.getReservas();
    _reservas_2.add(reserva3);
    List<Reserva> _reservas_3 = this.auto4.getReservas();
    _reservas_3.add(reserva4);
    List<Reserva> reservas = new ArrayList<Reserva>();
    reservas.add(reserva1);
    reservas.add(reserva2);
    reservas.add(reserva3);
    reservas.add(reserva4);
    Empresa _empresa = new Empresa("50-43243252-3", "Pepito Autos", reservas);
    this.empresa = _empresa;
    this.rentAutoS.<Empresa>anadir(this.empresa);
  }
  
  @Test
  public void anadirFiatPunto2013() {
    Deportivo _deportivo = new Deportivo();
    Double _double = new Double(1000);
    Ubicacion _ubicacion = new Ubicacion("");
    Auto auto5 = new Auto("Fiat", "Punto", Integer.valueOf(2013), "LBG204", _deportivo, _double, _ubicacion);
    this.rentAutoS.<Auto>anadir(auto5);
  }
  
  @Test
  public void testObtenerTotalAutos() {
    List<Auto> totalAutos = this.rentAutoS.obtenerTotalAutos();
    int _size = totalAutos.size();
    Assert.assertEquals(4, _size);
  }
  
  /**
   * Como usuario quiero saber los autos disponibles en una determinada ubicación un determinado día.
   */
  @Test
  public void testFiatUnoYFiatSienaDisponibles() {
    Ubicacion ubicacionInicial = this.ubicacionRetiro;
    Date fechaInicio = DateExtensions.nuevaFecha(2015, 12, 8);
    List<Auto> autosDisponibles = this.rentAutoS.obtenerAutosDisponibles(ubicacionInicial, fechaInicio, null, null);
    Auto _get = autosDisponibles.get(0);
    String _patente = _get.getPatente();
    Assert.assertEquals("ABC123", _patente);
    Auto _get_1 = autosDisponibles.get(1);
    String _patente_1 = _get_1.getPatente();
    Assert.assertEquals("ABR459", _patente_1);
    int _size = autosDisponibles.size();
    Assert.assertEquals(2, _size);
  }
  
  @Test
  public void testNoHayDisponiblesEnMoronEnFecha() {
    Ubicacion ubicacionInicial = this.ubicacionMoron;
    Date fechaInicio = DateExtensions.nuevaFecha(2015, 12, 21);
    List<Auto> autosDisponibles = this.rentAutoS.obtenerAutosDisponibles(ubicacionInicial, fechaInicio, null, null);
    int _size = autosDisponibles.size();
    Assert.assertEquals(0, _size);
  }
  
  @Test
  public void testSoloFiatPuntoDisponible() {
    Ubicacion ubicacionInicial = this.ubicacionBerazategui;
    Date fechaInicio = DateExtensions.nuevaFecha(2015, 12, 19);
    List<Auto> autosDisponibles = this.rentAutoS.obtenerAutosDisponibles(ubicacionInicial, fechaInicio, null, null);
    int _size = autosDisponibles.size();
    Assert.assertEquals(1, _size);
  }
  
  @Test
  public void testNoHayDisponiblesEnUbicacion() {
    Ubicacion ubicacionInicial = this.ubicacionLanus;
    Date fechaInicio = DateExtensions.nuevaFecha(2015, 11, 10);
    List<Auto> autosDisponibles = this.rentAutoS.obtenerAutosDisponibles(ubicacionInicial, fechaInicio, null, null);
    int _size = autosDisponibles.size();
    Assert.assertEquals(0, _size);
  }
  
  @Test
  public void testTotalAutosFamiliares() {
    this.rentAutoS.<Auto>anadir(this.auto5);
    Familiar _familiar = new Familiar();
    List<Auto> autosDisponibles = this.rentAutoS.obtenerAutosDisponibles(null, null, null, _familiar);
    int _size = autosDisponibles.size();
    Assert.assertEquals(3, _size);
  }
  
  /**
   * Como usuario quiero hacer una reserva.
   */
  @Test
  public void testRealizoReservaCorrectamente() {
    Date _nuevaFecha = DateExtensions.nuevaFecha(2015, 12, 10);
    Date _nuevaFecha_1 = DateExtensions.nuevaFecha(2015, 12, 15);
    Reserva reserva = new Reserva(this.auto5, this.ubicacionMoron, this.ubicacionMarcos_Paz, _nuevaFecha, _nuevaFecha_1, this.usuario1);
    List<IUsuario> _usuarios = this.empresa.getUsuarios();
    _usuarios.add(this.usuario1);
    this.empresa.agregarReserva(reserva);
    this.rentAutoS.realizarReserva(reserva);
  }
  
  @Test(expected = ReservaException.class)
  public void testUsuarioNoPerteneceAEmpresa() {
    Date _nuevaFecha = DateExtensions.nuevaFecha(2015, 10, 10);
    Date _nuevaFecha_1 = DateExtensions.nuevaFecha(2015, 10, 11);
    Reserva reserva = new Reserva(this.auto5, this.ubicacionMoron, this.ubicacionBerazategui, _nuevaFecha, _nuevaFecha_1, this.usuario1);
    this.empresa.agregarReserva(reserva);
    this.rentAutoS.realizarReserva(reserva);
  }
  
  @After
  public void limpiar() {
    SessionManager.resetSessionFactory();
  }
}
