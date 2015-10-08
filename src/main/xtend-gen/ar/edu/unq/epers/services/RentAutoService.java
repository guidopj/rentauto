package ar.edu.unq.epers.services;

import ar.edu.unq.epers.model.Auto;
import ar.edu.unq.epers.model.Categoria;
import ar.edu.unq.epers.model.Reserva;
import ar.edu.unq.epers.model.Ubicacion;
import ar.edu.unq.epers.persistens.AutoHome;
import ar.edu.unq.epers.sesiones.SessionManager;
import com.google.common.base.Objects;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Functions.Function0;
import org.eclipse.xtext.xbase.lib.Pure;

@Accessors
@SuppressWarnings("all")
public class RentAutoService {
  private AutoHome autoHome;
  
  public RentAutoService(final AutoHome autoH) {
    this.autoHome = autoH;
  }
  
  public <T extends Object> T ejecutarBloque(final Function0<T> bloque) {
    final Function0<T> _function = new Function0<T>() {
      @Override
      public T apply() {
        return bloque.apply();
      }
    };
    return SessionManager.<T>runInSession(_function);
  }
  
  public <T extends Object> Serializable anadir(final T element) {
    final Function0<Serializable> _function = new Function0<Serializable>() {
      @Override
      public Serializable apply() {
        return RentAutoService.this.autoHome.<T>guardar(element);
      }
    };
    return this.<Serializable>ejecutarBloque(_function);
  }
  
  public Auto getAuto(final int id) {
    final Function0<Auto> _function = new Function0<Auto>() {
      @Override
      public Auto apply() {
        return RentAutoService.this.autoHome.obtenerAuto(id);
      }
    };
    return this.<Auto>ejecutarBloque(_function);
  }
  
  private boolean esMismaUbicacion(final Ubicacion u, final Ubicacion u1) {
    String _nombre = u.getNombre();
    String _nombre_1 = u1.getNombre();
    return _nombre.equals(_nombre_1);
  }
  
  private boolean tieneReservaDesdeInicio(final Auto a, final Date fecha) {
    boolean _xblockexpression = false;
    {
      List<Reserva> _reservas = a.getReservas();
      for (final Reserva r : _reservas) {
        Date _inicio = r.getInicio();
        boolean _after = _inicio.after(fecha);
        if (_after) {
          return true;
        }
      }
      _xblockexpression = false;
    }
    return _xblockexpression;
  }
  
  private boolean tieneReservaHastaFin(final Auto a, final Date fecha) {
    boolean _xblockexpression = false;
    {
      List<Reserva> _reservas = a.getReservas();
      for (final Reserva r : _reservas) {
        Date _fin = r.getFin();
        boolean _before = _fin.before(fecha);
        if (_before) {
          return true;
        }
      }
      _xblockexpression = false;
    }
    return _xblockexpression;
  }
  
  public List<Auto> obtenerAutosDisponibles(final Ubicacion origen, final Date inicio, final Date fin, final Categoria cat) {
    final Function0<List<Auto>> _function = new Function0<List<Auto>>() {
      @Override
      public List<Auto> apply() {
        List<Auto> _xblockexpression = null;
        {
          List<Auto> autosDisponibles = new ArrayList<Auto>();
          List<Auto> autos = RentAutoService.this.autoHome.obtenerAutos();
          for (final Auto a : autos) {
            boolean _satisfaceFiltro = RentAutoService.this.satisfaceFiltro(a, origen, inicio, fin, cat);
            if (_satisfaceFiltro) {
              autosDisponibles.add(a);
            }
          }
          _xblockexpression = autosDisponibles;
        }
        return _xblockexpression;
      }
    };
    return this.<List<Auto>>ejecutarBloque(_function);
  }
  
  public boolean satisfaceFiltro(final Auto auto, final Ubicacion origen, final Date inicio, final Date fin, final Categoria categoria) {
    boolean _xblockexpression = false;
    {
      boolean boolRes = true;
      boolean _notEquals = (!Objects.equal(origen, null));
      if (_notEquals) {
        boolean _and = false;
        if (!boolRes) {
          _and = false;
        } else {
          Ubicacion _ubicacionInicial = auto.getUbicacionInicial();
          boolean _esMismaUbicacion = this.esMismaUbicacion(origen, _ubicacionInicial);
          _and = _esMismaUbicacion;
        }
        boolRes = _and;
      }
      boolean _notEquals_1 = (!Objects.equal(inicio, null));
      if (_notEquals_1) {
        boolean _and_1 = false;
        if (!boolRes) {
          _and_1 = false;
        } else {
          boolean _tieneReservaDesdeInicio = this.tieneReservaDesdeInicio(auto, inicio);
          _and_1 = _tieneReservaDesdeInicio;
        }
        boolRes = _and_1;
      }
      boolean _notEquals_2 = (!Objects.equal(fin, null));
      if (_notEquals_2) {
        boolean _and_2 = false;
        if (!boolRes) {
          _and_2 = false;
        } else {
          boolean _tieneReservaHastaFin = this.tieneReservaHastaFin(auto, fin);
          _and_2 = _tieneReservaHastaFin;
        }
        boolRes = _and_2;
      }
      boolean _notEquals_3 = (!Objects.equal(categoria, null));
      if (_notEquals_3) {
        boolean _and_3 = false;
        if (!boolRes) {
          _and_3 = false;
        } else {
          boolean _tieneMismaCategoria = this.tieneMismaCategoria(auto, categoria);
          _and_3 = _tieneMismaCategoria;
        }
        boolRes = _and_3;
      }
      _xblockexpression = boolRes;
    }
    return _xblockexpression;
  }
  
  public boolean tieneMismaCategoria(final Auto auto, final Categoria categoria) {
    Categoria _categoria = auto.getCategoria();
    String _nombre = _categoria.getNombre();
    String _nombre_1 = categoria.getNombre();
    return _nombre.equals(_nombre_1);
  }
  
  public List<Auto> obtenerTotalAutos() {
    final Function0<List<Auto>> _function = new Function0<List<Auto>>() {
      @Override
      public List<Auto> apply() {
        return RentAutoService.this.autoHome.obtenerAutos();
      }
    };
    return this.<List<Auto>>ejecutarBloque(_function);
  }
  
  public Serializable realizarReserva(final Reserva reservaNueva) {
    Serializable _xblockexpression = null;
    {
      reservaNueva.reservar();
      _xblockexpression = this.<Reserva>anadir(reservaNueva);
    }
    return _xblockexpression;
  }
  
  @Pure
  public AutoHome getAutoHome() {
    return this.autoHome;
  }
  
  public void setAutoHome(final AutoHome autoHome) {
    this.autoHome = autoHome;
  }
}
