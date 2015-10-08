package ar.edu.unq.epers.model;

import ar.edu.unq.epers.excepciones.ConexionFallidaException;
import ar.edu.unq.epers.model.Usuario;
import ar.edu.unq.epers.persistens.UsuarioHome;
import ar.edu.unq.epers.services.UsuarioService;
import com.google.common.base.Objects;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

@SuppressWarnings("all")
public class HomeSistema_Test {
  private UsuarioService sistema;
  
  @Before
  public void setUp() {
    UsuarioService _usuarioService = new UsuarioService();
    this.sistema = _usuarioService;
    Date _valueOf = Date.valueOf("2001-09-04");
    this.sistema.registrar("PEPITO", "GOMEZ", "PEPGOM", "pepitoGomez@yahoo.com.ar", _valueOf, "");
  }
  
  @Test
  public void usuarioPorCodigoValidacionPEPITO() {
    UsuarioHome _homeUsuario = this.sistema.getHomeUsuario();
    final Usuario u = _homeUsuario.getUsuarioPorCodigoValidacion("PEPGOM1357");
    String _nombreDeUsuario = u.getNombreDeUsuario();
    Assert.assertEquals("PEPGOM", _nombreDeUsuario);
  }
  
  @Test
  public void usuarioPorCodigoValidacionPEPITOP_NoExiste() {
    UsuarioHome _homeUsuario = this.sistema.getHomeUsuario();
    final Usuario u = _homeUsuario.getUsuarioPorCodigoValidacion("PEPPGOM1357");
    Assert.assertNull(u);
  }
  
  @Test
  public void usuarioPorNombreUsuarioPEPITO() {
    UsuarioHome _homeUsuario = this.sistema.getHomeUsuario();
    final Usuario u = _homeUsuario.getUsuarioPorNombreUsuario("PEPGOM");
    Assert.assertNotNull(u);
  }
  
  @Test
  public void usuarioPorNombreUsuarioPEPITOP_NoExiste() {
    UsuarioHome _homeUsuario = this.sistema.getHomeUsuario();
    final Usuario u = _homeUsuario.getUsuarioPorNombreUsuario("PEPPGOM");
    Assert.assertNull(u);
  }
  
  private Connection getConnection() {
    try {
      Class.forName("com.mysql.jdbc.Driver");
      return DriverManager.getConnection("jdbc:mysql://localhost/Pers_TP1?user=root&password=root");
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  @After
  public void tearDown() {
    try {
      Connection conn = null;
      PreparedStatement ps1 = null;
      PreparedStatement ps2 = null;
      try {
        Connection _connection = this.getConnection();
        conn = _connection;
        PreparedStatement _prepareStatement = conn.prepareStatement("DELETE FROM Usuarios WHERE NOMBRE_USUARIO=\'PEPGOM\'");
        ps1 = _prepareStatement;
        PreparedStatement _prepareStatement_1 = conn.prepareStatement("DELETE FROM Usuarios_Codigo_Validacion WHERE NOMBRE_USUARIO=\'PEPGOM\'");
        ps2 = _prepareStatement_1;
        ps1.execute();
        ps2.execute();
      } catch (final Throwable _t) {
        if (_t instanceof SQLException) {
          final SQLException e = (SQLException)_t;
          throw new ConexionFallidaException();
        } else {
          throw Exceptions.sneakyThrow(_t);
        }
      } finally {
        boolean _notEquals = (!Objects.equal(ps1, null));
        if (_notEquals) {
          ps1.close();
        }
        boolean _notEquals_1 = (!Objects.equal(ps2, null));
        if (_notEquals_1) {
          ps2.close();
        }
        boolean _notEquals_2 = (!Objects.equal(conn, null));
        if (_notEquals_2) {
          conn.close();
        }
      }
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
}
