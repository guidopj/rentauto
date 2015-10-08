package ar.edu.unq.epers.model;

import ar.edu.unq.epers.model.Auto;
import ar.edu.unq.epers.model.Categoria;
import ar.edu.unq.epers.model.IUsuario;
import ar.edu.unq.epers.model.Reserva;
import ar.edu.unq.epers.model.ReservaException;
import java.util.List;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.eclipse.xtext.xbase.lib.IterableExtensions;
import org.eclipse.xtext.xbase.lib.Pure;

@Accessors
@SuppressWarnings("all")
public class Empresa implements IUsuario {
  private Integer id_empresa;
  
  private String cuit;
  
  private String nombreEmpresa;
  
  private List<IUsuario> usuarios = CollectionLiterals.<IUsuario>newArrayList();
  
  private List<Reserva> reservas = CollectionLiterals.<Reserva>newArrayList();
  
  private int cantidadMaximaDeReservasActivas;
  
  private Double valorMaximoPorDia;
  
  private List<Categoria> categoriasAdmitidas = CollectionLiterals.<Categoria>newArrayList();
  
  public Empresa() {
  }
  
  public Empresa(final String cuit, final String nombreEmpresa, final List<Reserva> reservas) {
    this.cuit = cuit;
    this.nombreEmpresa = nombreEmpresa;
    this.reservas = reservas;
    this.cantidadMaximaDeReservasActivas = 2;
    Double _double = new Double(100);
    this.valorMaximoPorDia = _double;
  }
  
  @Override
  public void agregarReserva(final Reserva unaReserva) {
    this.validarReserva(unaReserva);
    this.reservas.add(unaReserva);
  }
  
  public void validarReserva(final Reserva unaReserva) {
    Iterable<Reserva> _reservasActivas = this.reservasActivas();
    int _size = IterableExtensions.size(_reservasActivas);
    String _plus = ("reserevas activas size = " + Integer.valueOf(_size));
    String _plus_1 = (_plus + " y cantMax = ");
    String _plus_2 = (_plus_1 + Integer.valueOf(this.cantidadMaximaDeReservasActivas));
    System.out.println(_plus_2);
    Iterable<Reserva> _reservasActivas_1 = this.reservasActivas();
    int _size_1 = IterableExtensions.size(_reservasActivas_1);
    boolean _equals = (_size_1 == this.cantidadMaximaDeReservasActivas);
    if (_equals) {
      throw new ReservaException("No se pueden tener más reservas para esta empresa");
    }
    int _costoPorDia = unaReserva.costoPorDia();
    boolean _greaterThan = (_costoPorDia > (this.valorMaximoPorDia).doubleValue());
    if (_greaterThan) {
      throw new ReservaException("El costo por dia excede el maximo de la empresa");
    }
    IUsuario _usuario = unaReserva.getUsuario();
    boolean _contains = this.usuarios.contains(_usuario);
    boolean _not = (!_contains);
    if (_not) {
      throw new ReservaException("El usuario no pertenece a la empresa");
    }
    boolean _and = false;
    boolean _isEmpty = this.categoriasAdmitidas.isEmpty();
    boolean _not_1 = (!_isEmpty);
    if (!_not_1) {
      _and = false;
    } else {
      Auto _auto = unaReserva.getAuto();
      Categoria _categoria = _auto.getCategoria();
      boolean _contains_1 = this.categoriasAdmitidas.contains(_categoria);
      boolean _not_2 = (!_contains_1);
      _and = _not_2;
    }
    if (_and) {
      throw new ReservaException("La categoria no esta admitida por la empresa");
    }
  }
  
  public Iterable<Reserva> reservasActivas() {
    final Function1<Reserva, Boolean> _function = new Function1<Reserva, Boolean>() {
      @Override
      public Boolean apply(final Reserva it) {
        return Boolean.valueOf(it.isActiva());
      }
    };
    return IterableExtensions.<Reserva>filter(this.reservas, _function);
  }
  
  @Pure
  public Integer getId_empresa() {
    return this.id_empresa;
  }
  
  public void setId_empresa(final Integer id_empresa) {
    this.id_empresa = id_empresa;
  }
  
  @Pure
  public String getCuit() {
    return this.cuit;
  }
  
  public void setCuit(final String cuit) {
    this.cuit = cuit;
  }
  
  @Pure
  public String getNombreEmpresa() {
    return this.nombreEmpresa;
  }
  
  public void setNombreEmpresa(final String nombreEmpresa) {
    this.nombreEmpresa = nombreEmpresa;
  }
  
  @Pure
  public List<IUsuario> getUsuarios() {
    return this.usuarios;
  }
  
  public void setUsuarios(final List<IUsuario> usuarios) {
    this.usuarios = usuarios;
  }
  
  @Pure
  public List<Reserva> getReservas() {
    return this.reservas;
  }
  
  public void setReservas(final List<Reserva> reservas) {
    this.reservas = reservas;
  }
  
  @Pure
  public int getCantidadMaximaDeReservasActivas() {
    return this.cantidadMaximaDeReservasActivas;
  }
  
  public void setCantidadMaximaDeReservasActivas(final int cantidadMaximaDeReservasActivas) {
    this.cantidadMaximaDeReservasActivas = cantidadMaximaDeReservasActivas;
  }
  
  @Pure
  public Double getValorMaximoPorDia() {
    return this.valorMaximoPorDia;
  }
  
  public void setValorMaximoPorDia(final Double valorMaximoPorDia) {
    this.valorMaximoPorDia = valorMaximoPorDia;
  }
  
  @Pure
  public List<Categoria> getCategoriasAdmitidas() {
    return this.categoriasAdmitidas;
  }
  
  public void setCategoriasAdmitidas(final List<Categoria> categoriasAdmitidas) {
    this.categoriasAdmitidas = categoriasAdmitidas;
  }
}
