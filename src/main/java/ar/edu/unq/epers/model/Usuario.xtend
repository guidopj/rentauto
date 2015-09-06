package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors
import java.sql.Date

@Accessors
class Usuario {
	String nombre;
	String apellido;
	String nombre_de_usuario;
	String contrasena;
	String email;
	Date fecha_de_nac;
	Boolean validado;
	
	new(String nombre, String apellido, String nombreUsuario, String email, Date fecha, String contrasena) {
		this.nombre = nombre;
		this.apellido = apellido;
		this.nombre_de_usuario = nombreUsuario;
		this.email = email;
		this.fecha_de_nac = fecha;
		this.contrasena = contrasena;
		this.validado = false;
	}
	
	new(){}
	
	def validarme() {
		this.validado = true;
	}
	
}