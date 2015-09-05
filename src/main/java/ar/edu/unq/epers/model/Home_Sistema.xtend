package ar.edu.unq.epers.model

import java.sql.Connection
import java.sql.DriverManager
import java.sql.PreparedStatement
import java.sql.ResultSet
import org.eclipse.xtext.xbase.lib.Functions.Function1
import java.util.Random

class Home_Sistema {
	
	def queryDb(Function1<Connection, Usuario> bloque) {
		var Connection conn = null;
		var PreparedStatement ps = null;
		try{
			conn = this.getConnection();
			return bloque.apply(conn) as Usuario;
		}finally{
			if(conn != null)
				conn.close();
		}
	}
	
	def updateDb(Function1<Connection, Boolean> bloque) {
		var Connection conn = null;
		try{
			conn = this.getConnection();
			bloque.apply(conn);
			//ps.execute();
		}finally{
			if(conn != null)
				conn.close();
			
		}
	}
	
	
	def getUsuarioPorCodigoValidacion(String cod){
		this.queryDb([conn|
        	var PreparedStatement ps1  = conn.prepareStatement("SELECT * FROM USUARIOS where codigo_validacion = ?");
			ps1.setString(1, cod);
			var ResultSet rs = ps1.executeQuery();
			if(rs.next()){
//				val Usuario usuario = new Usuario => [
//					nombre = rs.getString("NOMBRE");
//				]
				val Usuario usuario = new Usuario();
				usuario.nombre = rs.getString("NOMBRE");
				usuario.apellido = rs.getString("APELLIDO");
				usuario.nombre_de_usuario = rs.getString("NOMBRE_USUARIO");
				usuario.email = rs.getString("EMAIL");
				usuario.fecha_de_nac = rs.getDate("FECHA_DE_NAC");
				usuario.validado = rs.getBoolean("VALIDADO");
				ps1.close();
				return usuario;
			}else{
				ps1.close();
				return null;
			}
		])
	}
	
	def actualizarUsuario(Usuario usuario){
		this.updateDb([conn|
			val PreparedStatement ps1 = conn.prepareStatement("UPDATE Usuarios (NOMBRE, APELLIDO, NOMBRE_USUARIO, EMAIL, FECHA_DE_NAC, VALIDADO) SET NOMBRE = ?, APELLIDO = ?,NOMBRE_USUARIO = ?, EMAIL = ?, FECHA_DE_NAC = ?,VALIDADO = ?");
			ps1.setString(1, usuario.nombre);
			ps1.setString(2, usuario.apellido);
			ps1.setString(3, usuario.nombre_de_usuario);
			ps1.setString(4, usuario.email);
			ps1.setDate(5, usuario.fecha_de_nac);
			ps1.setBoolean(6,usuario.validado);
			ps1.execute();
		])
	}
	
	def guardarUsuario(Usuario usuario){
		this.updateDb([conn|
			val PreparedStatement ps1 = conn.prepareStatement("INSERT INTO Usuarios (NOMBRE, APELLIDO, NOMBRE_USUARIO, EMAIL, FECHA_DE_NAC, VALIDADO) VALUES(?,?,?,?,?,?)");
			ps1.setString(1, usuario.nombre);
			ps1.setString(2, usuario.apellido);
			ps1.setString(3, usuario.nombre_de_usuario);
			ps1.setString(4, usuario.email);
			ps1.setDate(5, usuario.fecha_de_nac);
			ps1.setBoolean(6,false);
			ps1.execute();
			
			val Random r = new Random();
			val cod_val = r.nextInt(10000);
			val PreparedStatement ps2 = conn.prepareStatement("INSERT INTO Usuarios_Codigo_Validacion (NOMBRE_USUARIO, CODIGO_VALIDACION) VALUES(?,?)");
			ps2.setString(1, usuario.nombre_de_usuario);
			ps2.setInt(2, cod_val);
			
			ps2.execute();
		])
	}
	
	def private Connection getConnection(){
		Class.forName("com.mysql.jdbc.Driver");
		return DriverManager.getConnection("jdbc:mysql://localhost/Pers_TP1?user=root&password=root");
	}
}