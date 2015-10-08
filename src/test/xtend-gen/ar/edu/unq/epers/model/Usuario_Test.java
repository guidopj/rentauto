package ar.edu.unq.epers.model;

import ar.edu.unq.epers.model.Usuario;
import java.sql.Date;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

@SuppressWarnings("all")
public class Usuario_Test {
  private Date fechaNac;
  
  private Usuario usuario1;
  
  @Before
  public void setUp() {
    Date _date = new Date(1990, 01, 01);
    this.fechaNac = _date;
    Usuario _usuario = new Usuario("usu1Nombre", "usu1Apellido", "usu1Nombre_Usaurio", "usu1_email", this.fechaNac, "");
    this.usuario1 = _usuario;
  }
  
  @Test
  public void validarUSU1() {
    this.usuario1.validarme();
    Boolean _validado = this.usuario1.getValidado();
    Assert.assertEquals(Boolean.valueOf(true), _validado);
  }
}
