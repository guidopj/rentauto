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
		//var Connection conn = this.getConnection();
	}
	
	def private Connection getConnection(){
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost/Pers_TP1?user=root&password=root");
	}
	
	@Test
	def void registrar_pepito_Usuarios(){
		sis.registrar("PEPITO","GOMEZ","PEPGOM","pepitoGomez@yahoo.com.ar",fechaNac,"");
		val Usuario u = sis.homeSistema.getUsuarioPorNombreUsuario("PEPGOM");
		Assert.assertFalse(u.equals(null))
		Assert.assertTrue(u.nombre.equals("PEPITO"));
		Assert.assertEquals(false,u.validado);
	}
	
	@Test
	def void registrar_pepito_Usuarios_CodigosVal(){
		sis.registrar("PEPITO","GOMEZ","PEPGOM","pepitoGomez@yahoo.com.ar",fechaNac,"");
		
		val Usuario u = sis.homeSistema.getUsuarioPorNombreUsuario("PEPGOM");
		Assert.assertNotNull(u);
	}
	
	@Test
	def void registrar_pepitoP_Usuarios_CodigosVal(){
		sis.registrar("PEPITO","GOMEZ","PEPGOM","pepitoGomez@yahoo.com.ar",fechaNac,"");
		val Usuario u = sis.homeSistema.getUsuarioPorNombreUsuario("PEPPGOM");
		Assert.assertNull(u)
	}
	
	@Test
	def void validar_PEPITO_existe(){
		sis.registrar("PEPITO","GOMEZ","PEPGOM","pepitoGomez@yahoo.com.ar",java.sql.Date.valueOf("2013-09-04"),"");
		sis.validarCuenta("PEPGOM1357");

		val Usuario u = sis.homeSistema.getUsuarioPorNombreUsuario("PEPGOM");
		Assert.assertTrue(u.validado);
	}
	
	@Test(expected=UsuarioNoExisteException)
	def void validar_PEPITOP_NOexiste(){
		sis.registrar("PEPITO","GOMEZ","PEPGOM","pepitoGomez@yahoo.com.ar",fechaNac,"");
		sis.validarCuenta("PEPPGOM1357");
	}
	
	@Test(expected=ContrasenaInvalidaException)
	def testIngresarUsuarioContrasenaInvalida(){
		sis.registrar("PEPITO","GOMEZ","PEPGOM","pepitoGomez@yahoo.com.ar",fechaNac,"aaa");
		sis.validarCuenta("PEPGOM1357");
		
		Assert.assertEquals(sis.ingresarUsuario("PEPGOM", "aaaaa"),typeof(Usuario))
	}
	
	@Test(expected=UsuarioNoValidadoException)
	def testIngresarUsuarioNoValidado(){	
		sis.registrar("PEPITO","GOMEZ","PEPGOM","pepitoGomez@yahoo.com.ar",fechaNac,"aaa");
		Assert.assertEquals(sis.ingresarUsuario("PEPGOM", "aaa"),typeof(Usuario))
	}
	
	@Test
	def testIngresarUsuarioExiste(){
		sis.registrar("PEPITO","GOMEZ","PEPGOM","pepitoGomez@yahoo.com.ar",fechaNac,"aaa");
		sis.validarCuenta("PEPGOM1357");
		Assert.assertEquals(sis.ingresarUsuario("PEPGOM", "aaa").class,typeof(Usuario))
	}
	
	
	@Test
	def void cambiarContrasenaCorrecto(){
		sis.registrar("PEPITO","GOMEZ","PEPGOM","pepitoGomez@yahoo.com.ar",fechaNac,"viejaAAA");
		sis.cambiarContrasena("PEPGOM", "viejaAAA", "nuevaAAA");
		val Usuario u = sis.homeSistema.getUsuarioPorNombreUsuario("PEPGOM");
		Assert.assertEquals("nuevaAAA",u.contrasena);
	}
	
	@Test(expected=ContrasenaInvalidaException)
	def void cambiarContrasenaInvalida(){
		sis.registrar("PEPITO","GOMEZ","PEPGOM","pepitoGomez@yahoo.com.ar",fechaNac,"viejaAAA");
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

//	@Test
//	def registrar_pepito(){
//		sis.registrar("PEPITO","GOMEZ","PEPGOM","pepitoGomez@yahoo.com.ar",fechaNac);
//		
//		var Connection conn = null;
//		var PreparedStatement ps = null;
//		try{	
//			conn = this.getConnection();
//			ps = conn.prepareStatement("SELECT * FROM Usuarios WHERE NOMBRE_USUARIO='PEPGOM'");
//
//			var ResultSet rs = ps.executeQuery();
//			
//			Assert.assertFalse(rs.next().equals(null))
//			Assert.assertTrue(rs.getString("NOMBRE").equals("PEPITO"));
//		
//		}finally{
//			if(ps != null)
//				ps.close();
//			if(conn != null)
//				conn.close();
//		}
//		
//	}




//		sis.homeSistema.queryDb[conn|
//			var PreparedStatement ps3  = conn.prepareStatement("SELECT * FROM Usuarios WHERE NOMBRE_USUARIO= 'PEPGOM'");
//			var ResultSet rs = ps3.executeQuery();
//			Assert.assertFalse(rs.next().equals(null))
//			Assert.assertTrue(rs.getString("NOMBRE").equals("PEPITO"));
//			Assert.assertEquals(0,rs.getInt("VALIDADO"))
//			return null;
//		]