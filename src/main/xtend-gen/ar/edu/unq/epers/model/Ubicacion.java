package ar.edu.unq.epers.model;

import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;

@Accessors
@SuppressWarnings("all")
public class Ubicacion {
  private int id_ubicacion;
  
  private String nombre;
  
  public Ubicacion() {
  }
  
  public Ubicacion(final String nombre) {
    this.nombre = nombre;
  }
  
  @Pure
  public int getId_ubicacion() {
    return this.id_ubicacion;
  }
  
  public void setId_ubicacion(final int id_ubicacion) {
    this.id_ubicacion = id_ubicacion;
  }
  
  @Pure
  public String getNombre() {
    return this.nombre;
  }
  
  public void setNombre(final String nombre) {
    this.nombre = nombre;
  }
}
