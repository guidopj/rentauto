package ar.edu.unq.epers.model;

import ar.edu.unq.epers.model.Auto;
import ar.edu.unq.epers.model.Categoria;

@SuppressWarnings("all")
public class Turismo extends Categoria {
  public Turismo() {
    this.setNombre("Turismo");
  }
  
  @Override
  public Double calcularCosto(final Auto auto) {
    Integer _anio = auto.getAnio();
    boolean _greaterThan = ((_anio).intValue() > 2000);
    if (_greaterThan) {
      Double _costoBase = auto.getCostoBase();
      return Double.valueOf(((_costoBase).doubleValue() * 1.10));
    } else {
      Double _costoBase_1 = auto.getCostoBase();
      return Double.valueOf(((_costoBase_1).doubleValue() - 200));
    }
  }
}