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

class Sistema_Test {
	
	Sistema sis;
	Date fechaNac;
	@Before
	def void setUp(){
		sis = new Sistema();
		var Connection conn = this.getConnection();
		
	}
	
	def private Connection getConnection(){
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost/Pers_TP1?user=root&password=root");
	}

	@Test
	def void registrar_pepito_Usuarios(){
		sis.registrar("PEPITO","GOMEZ","PEPGOM","pepitoGomez@yahoo.com.ar",fechaNac,"");
		sis.homeSistema.queryDb[conn|
			var PreparedStatement ps3  = conn.prepareStatement("SELECT * FROM Usuarios WHERE NOMBRE_USUARIO= 'PEPGOM'");
			var ResultSet rs = ps3.executeQuery();
			Assert.assertFalse(rs.next().equals(null))
			Assert.assertTrue(rs.getString("NOMBRE").equals("PEPITO"));
			return null;
		]
	}
	
	@Test
	def void registrar_pepito_Usuarios_CodigosVal(){
		sis.registrar("PEPITO","GOMEZ","PEPGOM","pepitoGomez@yahoo.com.ar",fechaNac,"");
		sis.homeSistema.queryDb[conn|
			var PreparedStatement ps3  = conn.prepareStatement("SELECT * FROM Usuarios_Codigo_Validacion WHERE NOMBRE_USUARIO= 'PEPGOM'");
			var ResultSet rs = ps3.executeQuery();
			Assert.assertTrue(rs.next())
			return null;
			]
	}
	
	@Test
	def void registrar_pepitoP_Usuarios_CodigosVal(){
		sis.registrar("PEPITO","GOMEZ","PEPGOM","pepitoGomez@yahoo.com.ar",fechaNac,"");
		sis.homeSistema.queryDb[conn|
			var PreparedStatement ps3  = conn.prepareStatement("SELECT * FROM Usuarios_Codigo_Validacion WHERE NOMBRE_USUARIO= 'PEPPGOM'");
			var ResultSet rs = ps3.executeQuery();
			Assert.assertFalse(rs.next())
			return null;
			]
	}
	
	@Test
	def usuarioPorCodigoValidacionPEPITO(){
		sis.registrar("PEPITO","GOMEZ","PEPGOM","pepitoGomez@yahoo.com.ar",java.sql.Date.valueOf("2001-09-04"),"");
		val Usuario u = sis.homeSistema.getUsuarioPorCodigoValidacion("PEPGOM1357");
		Assert.assertEquals("PEPITO",u.nombre);
		Assert.assertEquals("PEPGOM",u.nombre_de_usuario);
	}
	
	@Test
	def void validar_PEPITO_existe(){
		sis.registrar("PEPITO","GOMEZ","PEPGOM","pepitoGomez@yahoo.com.ar",java.sql.Date.valueOf("2013-09-04"),"");
		sis.validarCuenta("PEPGOM1357");
		sis.homeSistema.queryDb[conn|
			var PreparedStatement ps3  = conn.prepareStatement("SELECT * FROM Usuarios WHERE NOMBRE_USUARIO= 'PEPGOM'");
			var ResultSet rs = ps3.executeQuery();
			rs.next();
			var Integer validado = rs.getInt("VALIDADO");
			Assert.assertEquals(validado,1);
			return null;
			]
	}
	
	@Test(expected=UsuarioNoExisteException)
	def void validar_PEPITOP_NOexiste(){
		sis.registrar("PEPITO","GOMEZ","PEPGOM","pepitoGomez@yahoo.com.ar",fechaNac,"");
		sis.validarCuenta("PEPPGOM1357");
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