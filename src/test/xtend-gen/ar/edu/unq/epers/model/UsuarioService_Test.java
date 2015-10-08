package ar.edu.unq.epers.model;

import ar.edu.unq.epers.excepciones.ConexionFallidaException;
import ar.edu.unq.epers.excepciones.ContrasenaInvalidaException;
import ar.edu.unq.epers.excepciones.UsuarioNoExisteException;
import ar.edu.unq.epers.excepciones.UsuarioNoValidadoException;
import ar.edu.unq.epers.mailing.IEnviadorDeMails;
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
import org.mockito.Mockito;
import org.mockito.stubbing.OngoingStubbing;

@SuppressWarnings("all")
public class UsuarioService_Test {
  private UsuarioService sis;
  
  private Date fechaNac;
  
  @Before
  public void setUp() {
    UsuarioService _usuarioService = new UsuarioService();
    this.sis = _usuarioService;
    this.sis.registrar("PEPITO", "GOMEZ", "PEPGOM", "pepitoGomez@yahoo.com.ar", this.fechaNac, "aaa");
  }
  
  private Connection getConnection() {
    try {
      Class.forName("com.mysql.jdbc.Driver");
      return DriverManager.getConnection("jdbc:mysql://localhost/Pers_TP1?user=root&password=root");
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  /**
   * TESTS CON ACCESO A DATOS
   */
  @Test
  public void registrar_pepito_Usuarios() {
    UsuarioHome _homeUsuario = this.sis.getHomeUsuario();
    final Usuario u = _homeUsuario.getUsuarioPorNombreUsuario("PEPGOM");
    boolean _equals = u.equals(null);
    Assert.assertFalse(_equals);
    String _nombre = u.getNombre();
    boolean _equals_1 = _nombre.equals("PEPITO");
    Assert.assertTrue(_equals_1);
    Boolean _validado = u.getValidado();
    Assert.assertEquals(Boolean.valueOf(false), _validado);
  }
  
  @Test
  public void registrar_pepito_Usuarios_CodigosVal() {
    UsuarioHome _homeUsuario = this.sis.getHomeUsuario();
    final Usuario u = _homeUsuario.getUsuarioPorNombreUsuario("PEPGOM");
    Assert.assertNotNull(u);
  }
  
  @Test
  public void registrar_pepitoP_Usuarios_CodigosVal() {
    UsuarioHome _homeUsuario = this.sis.getHomeUsuario();
    final Usuario u = _homeUsuario.getUsuarioPorNombreUsuario("PEPPGOM");
    Assert.assertNull(u);
  }
  
  @Test
  public void validar_PEPITO_existe() {
    this.sis.validarCuenta("PEPGOM1357");
    UsuarioHome _homeUsuario = this.sis.getHomeUsuario();
    final Usuario u = _homeUsuario.getUsuarioPorNombreUsuario("PEPGOM");
    Boolean _validado = u.getValidado();
    Assert.assertTrue((_validado).booleanValue());
  }
  
  @Test(expected = UsuarioNoExisteException.class)
  public void validar_PEPITOP_NOexiste() {
    this.sis.validarCuenta("PEPPGOM1357");
  }
  
  @Test(expected = ContrasenaInvalidaException.class)
  public void testIngresarUsuarioContrasenaInvalida() {
    this.sis.validarCuenta("PEPGOM1357");
    Usuario _ingresarUsuario = this.sis.ingresarUsuario("PEPGOM", "aaaaa");
    Assert.assertEquals(_ingresarUsuario, Usuario.class);
  }
  
  @Test(expected = UsuarioNoValidadoException.class)
  public void testIngresarUsuarioNoValidado() {
    Usuario _ingresarUsuario = this.sis.ingresarUsuario("PEPGOM", "aaa");
    Assert.assertEquals(_ingresarUsuario, Usuario.class);
  }
  
  @Test
  public void testIngresarUsuarioExiste() {
    this.sis.validarCuenta("PEPGOM1357");
    Usuario _ingresarUsuario = this.sis.ingresarUsuario("PEPGOM", "aaa");
    Class<? extends Usuario> _class = _ingresarUsuario.getClass();
    Assert.assertEquals(_class, Usuario.class);
  }
  
  @Test
  public void cambiarContrasenaCorrecto() {
    this.sis.cambiarContrasena("PEPGOM", "aaa", "nuevaAAA");
    UsuarioHome _homeUsuario = this.sis.getHomeUsuario();
    final Usuario u = _homeUsuario.getUsuarioPorNombreUsuario("PEPGOM");
    String _contrasena = u.getContrasena();
    Assert.assertEquals("nuevaAAA", _contrasena);
  }
  
  @Test(expected = ContrasenaInvalidaException.class)
  public void cambiarContrasenaInvalida() {
    this.sis.cambiarContrasena("PEPGOM", "viejaAAAAAA", "nuevaAAA");
  }
  
  /**
   * TEST DE MODELO Y NEGOCIO MOCKEANDO ACCESO A DATOS
   */
  @Test
  public void siElUsuarioExisteIngreso() {
    final Usuario user = new Usuario();
    user.setNombre("Pepito");
    user.setApellido("Gomez");
    user.setNombreDeUsuario("PEPGOM");
    user.setContrasena("BLA");
    Date _valueOf = Date.valueOf("2001-09-04");
    user.setFechaDeNac(_valueOf);
    user.setValidado(Boolean.valueOf(true));
    UsuarioHome _mock = Mockito.<UsuarioHome>mock(UsuarioHome.class);
    this.sis.setHomeUsuario(_mock);
    IEnviadorDeMails _mock_1 = Mockito.<IEnviadorDeMails>mock(IEnviadorDeMails.class);
    this.sis.setEnviadorMail(_mock_1);
    UsuarioHome _homeUsuario = this.sis.getHomeUsuario();
    Usuario _usuarioPorNombreUsuario = _homeUsuario.getUsuarioPorNombreUsuario("PEPGOM");
    OngoingStubbing<Usuario> _when = Mockito.<Usuario>when(_usuarioPorNombreUsuario);
    _when.thenReturn(user);
    final Usuario usuarioLogueado = this.sis.ingresarUsuario("PEPGOM", "BLA");
    Assert.assertEquals(usuarioLogueado, user);
  }
  
  @Test(expected = ContrasenaInvalidaException.class)
  public void testContrasenaInvalida() {
    final Usuario user = new Usuario();
    user.setNombre("Pepito");
    user.setApellido("Gomez");
    user.setNombreDeUsuario("PEPGOM");
    user.setContrasena("BLA");
    Date _valueOf = Date.valueOf("2001-09-04");
    user.setFechaDeNac(_valueOf);
    user.setValidado(Boolean.valueOf(true));
    UsuarioHome _mock = Mockito.<UsuarioHome>mock(UsuarioHome.class);
    this.sis.setHomeUsuario(_mock);
    IEnviadorDeMails _mock_1 = Mockito.<IEnviadorDeMails>mock(IEnviadorDeMails.class);
    this.sis.setEnviadorMail(_mock_1);
    UsuarioHome _homeUsuario = this.sis.getHomeUsuario();
    Usuario _usuarioPorNombreUsuario = _homeUsuario.getUsuarioPorNombreUsuario("PEPGOM");
    OngoingStubbing<Usuario> _when = Mockito.<Usuario>when(_usuarioPorNombreUsuario);
    _when.thenReturn(user);
    final Usuario usuarioLogueado = this.sis.ingresarUsuario("PEPGOM", "BLAH!");
  }
  
  @Test(expected = UsuarioNoValidadoException.class)
  public void testUsuarioNoValidado() {
    final Usuario user = new Usuario();
    user.setNombre("Pepito");
    user.setApellido("Gomez");
    user.setNombreDeUsuario("PEPGOM");
    user.setContrasena("BLA");
    Date _valueOf = Date.valueOf("2001-09-04");
    user.setFechaDeNac(_valueOf);
    user.setValidado(Boolean.valueOf(false));
    UsuarioHome _mock = Mockito.<UsuarioHome>mock(UsuarioHome.class);
    this.sis.setHomeUsuario(_mock);
    IEnviadorDeMails _mock_1 = Mockito.<IEnviadorDeMails>mock(IEnviadorDeMails.class);
    this.sis.setEnviadorMail(_mock_1);
    UsuarioHome _homeUsuario = this.sis.getHomeUsuario();
    Usuario _usuarioPorNombreUsuario = _homeUsuario.getUsuarioPorNombreUsuario("PEPGOM");
    OngoingStubbing<Usuario> _when = Mockito.<Usuario>when(_usuarioPorNombreUsuario);
    _when.thenReturn(user);
    final Usuario usuarioLogueado = this.sis.ingresarUsuario("PEPGOM", "BLA");
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
