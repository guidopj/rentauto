package ar.edu.unq.epers.model

import org.junit.Before
import org.junit.Test
import org.junit.Assert
import java.sql.Date
import java.sql.Connection
import java.sql.PreparedStatement
import java.sql.DriverManager
import java.sql.ResultSet
import org.junit.After

class Sistema_Test {
	
	Sistema sis;
	Date fechaNac;
	@Before
	def void setUp(){
		sis = new Sistema();
		fechaNac = new Date(1990,01,01);
		
	}
	
	def private Connection getConnection(){
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost/Pers_TP1?user=root&password=root");
	}
	
	@Test
	def registrar_pepito(){
		sis.registrar("PEPITO","GOMEZ","PEPGOM","pepitoGomez@yahoo.com.ar",fechaNac);
		
		var Connection conn = null;
		var PreparedStatement ps = null;
		try{	
			conn = this.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Usuarios WHERE NOMBRE_USUARIO='PEPGOM'");

			var ResultSet rs = ps.executeQuery();
			
			Assert.assertFalse(rs.next().equals(null))
			Assert.assertTrue(rs.getString("NOMBRE").equals("PEPITO"));
		
		}finally{
			if(ps != null)
				ps.close();
			if(conn != null)
				conn.close();
		}
		
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