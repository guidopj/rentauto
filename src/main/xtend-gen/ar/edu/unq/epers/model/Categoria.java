package ar.edu.unq.epers.model;

import ar.edu.unq.epers.model.Auto;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;

@Accessors
@SuppressWarnings("all")
public abstract class Categoria {
  private int id_Categoria;
  
  private String nombre;
  
  public Categoria() {
  }
  
  public abstract Double calcularCosto(final Auto auto);
  
  @Pure
  public int getId_Categoria() {
    return this.id_Categoria;
  }
  
  public void setId_Categoria(final int id_Categoria) {
    this.id_Categoria = id_Categoria;
  }
  
  @Pure
  public String getNombre() {
    return this.nombre;
  }
  
  public void setNombre(final String nombre) {
    this.nombre = nombre;
  }
}
