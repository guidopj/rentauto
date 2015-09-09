package ar.edu.unq.epers.model

import org.junit.Before
import org.junit.Test
import org.junit.Assert
import java.sql.Connection
import java.sql.PreparedStatement
import java.sql.DriverManager
import java.sql.ResultSet
import org.junit.After
import ar.edu.unq.epers.excepciones.UsuarioNoExisteException
import java.sql.Date
import ar.edu.unq.epers.excepciones.ContrasenaInvalidaException
import ar.edu.unq.epers.excepciones.UsuarioNoValidadoException

class Sistema_Test {
	
	Sistema sis;
	Date fechaNac;
	
	@Before
	def void setUp(){
		sis = new Sistema();
		sis.registrar("PEPITO","GOMEZ","PEPGOM","pepitoGomez@yahoo.com.ar",fechaNac,"aaa");
	}
	
	def private Connection getConnection(){
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost/Pers_TP1?user=root&password=root");
	}
	
	@Test
	def void registrar_pepito_Usuarios(){
		val Usuario u = sis.homeSistema.getUsuarioPorNombreUsuario("PEPGOM");
		Assert.assertFalse(u.equals(null))
		Assert.assertTrue(u.nombre.equals("PEPITO"));
		Assert.assertEquals(false,u.validado);
	}
	
	@Test
	def void registrar_pepito_Usuarios_CodigosVal(){
		
		val Usuario u = sis.homeSistema.getUsuarioPorNombreUsuario("PEPGOM");
		Assert.assertNotNull(u);
	}
	
	@Test
	def void registrar_pepitoP_Usuarios_CodigosVal(){
		val Usuario u = sis.homeSistema.getUsuarioPorNombreUsuario("PEPPGOM");
		Assert.assertNull(u)
	}
	
	@Test
	def void validar_PEPITO_existe(){
		sis.validarCuenta("PEPGOM1357");

		val Usuario u = sis.homeSistema.getUsuarioPorNombreUsuario("PEPGOM");
		Assert.assertTrue(u.validado);
	}
	
	@Test(expected=UsuarioNoExisteException)
	def void validar_PEPITOP_NOexiste(){
		sis.validarCuenta("PEPPGOM1357");
	}
	
	@Test(expected=ContrasenaInvalidaException)
	def testIngresarUsuarioContrasenaInvalida(){
		sis.validarCuenta("PEPGOM1357");
		
		Assert.assertEquals(sis.ingresarUsuario("PEPGOM", "aaaaa"),typeof(Usuario))
	}
	
	@Test(expected=UsuarioNoValidadoException)
	def testIngresarUsuarioNoValidado(){	
		Assert.assertEquals(sis.ingresarUsuario("PEPGOM", "aaa"),typeof(Usuario))
	}
	
	@Test
	def testIngresarUsuarioExiste(){
		sis.validarCuenta("PEPGOM1357");
		Assert.assertEquals(sis.ingresarUsuario("PEPGOM", "aaa").class,typeof(Usuario))
	}
	
	
	@Test
	def void cambiarContrasenaCorrecto(){
		sis.cambiarContrasena("PEPGOM", "aaa", "nuevaAAA");
		val Usuario u = sis.homeSistema.getUsuarioPorNombreUsuario("PEPGOM");
		Assert.assertEquals("nuevaAAA",u.contrasena);
	}
	
	@Test(expected=ContrasenaInvalidaException)
	def void cambiarContrasenaInvalida(){
		sis.cambiarContrasena("PEPGOM", "viejaAAAAAA", "nuevaAAA");
	}
	
		
	@After
	def void tearDown(){
		var Connection conn = null;
		var PreparedStatement ps1 = null;
		var PreparedStatement ps2 = null;
		try{	
			conn = this.getConnection();
			ps1 = conn.prepareStatement("DELETE FROM Usuarios WHERE NOMBRE_USUARIO='PEPGOM'");
			ps2 = conn.prepareStatement("DELETE FROM Usuarios_Codigo_Validacion WHERE NOMBRE_USUARIO='PEPGOM'");

			ps1.execute();
			ps2.execute();
		
		}finally{
			if(ps1 != null)
				ps1.close();
			if(ps2 != null)
				ps2.close();
			if(conn != null)
				conn.close();
		}
	}
}