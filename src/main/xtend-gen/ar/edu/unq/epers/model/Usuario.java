package ar.edu.unq.epers.model;

import ar.edu.unq.epers.excepciones.ContrasenaInvalidaException;
import ar.edu.unq.epers.excepciones.UsuarioNoValidadoException;
import ar.edu.unq.epers.model.IUsuario;
import ar.edu.unq.epers.model.Reserva;
import com.google.common.base.Objects;
import java.sql.Date;
import java.util.List;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.CollectionLiterals;
import org.eclipse.xtext.xbase.lib.Pure;

@Accessors
@SuppressWarnings("all")
public class Usuario implements IUsuario {
  private String nombre;
  
  private String apellido;
  
  private String nombreDeUsuario;
  
  private String contrasena;
  
  private String email;
  
  private Date fechaDeNac;
  
  private Boolean validado;
  
  private String codigoValidacion;
  
  private List<Reserva> reservas = CollectionLiterals.<Reserva>newArrayList();
  
  public Usuario(final String nombre, final String apellido, final String nombreUsuario, final String email, final Date fecha, final String contrasena) {
    this.nombre = nombre;
    this.apellido = apellido;
    this.nombreDeUsuario = nombreUsuario;
    this.email = email;
    this.fechaDeNac = fecha;
    this.contrasena = contrasena;
    this.validado = Boolean.valueOf(false);
    this.codigoValidacion = null;
  }
  
  public Usuario() {
  }
  
  public Boolean validarme() {
    return this.validado = Boolean.valueOf(true);
  }
  
  public void validarConstrasena(final String contrasena) {
    boolean _notEquals = (!Objects.equal(contrasena, this.contrasena));
    if (_notEquals) {
      throw new ContrasenaInvalidaException();
    }
  }
  
  public void validarIngreso() {
    if ((!(this.validado).booleanValue())) {
      throw new UsuarioNoValidadoException();
    }
  }
  
  @Override
  public void agregarReserva(final Reserva unaReserva) {
    this.reservas.add(unaReserva);
  }
  
  @Override
  public List<Reserva> getReservas() {
    return this.reservas;
  }
  
  @Pure
  public String getNombre() {
    return this.nombre;
  }
  
  public void setNombre(final String nombre) {
    this.nombre = nombre;
  }
  
  @Pure
  public String getApellido() {
    return this.apellido;
  }
  
  public void setApellido(final String apellido) {
    this.apellido = apellido;
  }
  
  @Pure
  public String getNombreDeUsuario() {
    return this.nombreDeUsuario;
  }
  
  public void setNombreDeUsuario(final String nombreDeUsuario) {
    this.nombreDeUsuario = nombreDeUsuario;
  }
  
  @Pure
  public String getContrasena() {
    return this.contrasena;
  }
  
  public void setContrasena(final String contrasena) {
    this.contrasena = contrasena;
  }
  
  @Pure
  public String getEmail() {
    return this.email;
  }
  
  public void setEmail(final String email) {
    this.email = email;
  }
  
  @Pure
  public Date getFechaDeNac() {
    return this.fechaDeNac;
  }
  
  public void setFechaDeNac(final Date fechaDeNac) {
    this.fechaDeNac = fechaDeNac;
  }
  
  @Pure
  public Boolean getValidado() {
    return this.validado;
  }
  
  public void setValidado(final Boolean validado) {
    this.validado = validado;
  }
  
  @Pure
  public String getCodigoValidacion() {
    return this.codigoValidacion;
  }
  
  public void setCodigoValidacion(final String codigoValidacion) {
    this.codigoValidacion = codigoValidacion;
  }
  
  public void setReservas(final List<Reserva> reservas) {
    this.reservas = reservas;
  }
}
