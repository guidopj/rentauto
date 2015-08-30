package ar.edu.unq.epers.model

import java.sql.Connection
import java.sql.DriverManager
import java.sql.PreparedStatement

class Home_Sistema {
	
	def anadir(Usuario usuario) {
		var Connection conn = null;
		var PreparedStatement ps = null;
		try{
			conn = this.getConnection();
			ps = conn.prepareStatement("INSERT INTO Usuarios (NOMBRE, APELLIDO, NOMBRE_USUARIO, EMAIL, FECHA_DE_NAC) VALUES (?,?,?,?,?)");
			ps.setString(1, usuario.nombre);
			ps.setString(2, usuario.apellido);
			ps.setString(3, usuario.nombre_de_usuario);
			ps.setString(4, usuario.email);
			ps.setDate(5, usuario.fecha_de_nac);
			ps.execute();
		}finally{
			if(ps != null)
				ps.close();
			if(conn != null)
				conn.close();
			
		}
	}
	
	def private Connection getConnection(){
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost/Epers_Ej1?user=root&password=root");
	}
}