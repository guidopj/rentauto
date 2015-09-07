package ar.edu.unq.epers.model

import org.junit.Before
import org.junit.Test
import org.junit.Assert
import java.sql.Connection
import java.sql.PreparedStatement
import java.sql.DriverManager
import org.junit.After

class HomeSistema_Test {
	
	Home_Sistema homeSistema;
	Sistema sistema;
	
	@Before
	def void setUp(){
		homeSistema = new Home_Sistema();
		sistema = new Sistema();
		sistema.registrar("PEPITO","GOMEZ","PEPGOM","pepitoGomez@yahoo.com.ar",java.sql.Date.valueOf("2001-09-04"),"");
	}
	
	@Test
	def usuarioPorCodigoValidacionPEPITO(){
		val Usuario u = homeSistema.getUsuarioPorCodigoValidacion("PEPGOM1357");
		Assert.assertEquals("PEPITO",u.nombre);
		Assert.assertEquals("PEPGOM",u.nombre_de_usuario);
	}
	
	def private Connection getConnection(){
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost/Pers_TP1?user=root&password=root");
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