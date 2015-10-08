package ar.edu.unq.epers.model;

import ar.edu.unq.epers.model.Auto;
import ar.edu.unq.epers.model.Deportivo;
import ar.edu.unq.epers.model.Familiar;
import ar.edu.unq.epers.model.Turismo;
import ar.edu.unq.epers.model.Ubicacion;
import ar.edu.unq.epers.persistens.AutoHome;
import ar.edu.unq.epers.services.RentAutoService;
import org.junit.Before;

@SuppressWarnings("all")
public class AutoHomeTest {
  private AutoHome autoHome;
  
  private Auto auto1;
  
  private Auto auto2;
  
  private Auto auto3;
  
  @Before
  public void startUp() {
    AutoHome _autoHome = new AutoHome();
    this.autoHome = _autoHome;
    RentAutoService rentAutoS = new RentAutoService(this.autoHome);
    Turismo _turismo = new Turismo();
    Double _double = new Double(1000);
    Ubicacion _ubicacion = new Ubicacion("Retiro");
    Auto _auto = new Auto("Fiat", "Uno", Integer.valueOf(1999), "ABC123", _turismo, _double, _ubicacion);
    this.auto1 = _auto;
    Deportivo _deportivo = new Deportivo();
    Double _double_1 = new Double(1000);
    Ubicacion _ubicacion_1 = new Ubicacion("Lanus");
    Auto _auto_1 = new Auto("Fiat", "Siena", Integer.valueOf(2011), "ABR459", _deportivo, _double_1, _ubicacion_1);
    this.auto2 = _auto_1;
    Familiar _familiar = new Familiar();
    Double _double_2 = new Double(1000);
    Ubicacion _ubicacion_2 = new Ubicacion("Moron");
    Auto _auto_2 = new Auto("Fiat", "Punto", Integer.valueOf(2015), "HTG205", _familiar, _double_2, _ubicacion_2);
    this.auto3 = _auto_2;
    rentAutoS.<Auto>anadir(this.auto1);
    rentAutoS.<Auto>anadir(this.auto2);
    rentAutoS.<Auto>anadir(this.auto3);
  }
}
