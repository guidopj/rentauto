package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors
import java.sql.Date
import ar.edu.unq.epers.excepciones.ContrasenaInvalidaException
import ar.edu.unq.epers.excepciones.UsuarioNoValidadoException
import java.util.List

@Accessors
class Usuario implements IUsuario{
	String nombre;
	String apellido;
	String nombreDeUsuario;
	String contrasena;
	String email;
	Date fechaDeNac;
	Boolean validado;
	String codigoValidacion;
	List<Reserva> reservas = newArrayList
	
	
	new(String nombre, String apellido, String nombreUsuario, String email, Date fecha, String contrasena) {
		this.nombre = nombre;
		this.apellido = apellido;
		this.nombreDeUsuario = nombreUsuario;
		this.email = email;
		this.fechaDeNac = fecha;
		this.contrasena = contrasena;
		this.validado = false;
		this.codigoValidacion = null;
	}
	
	new(String nombre, String apellido, String nombreUsuario, String email) {
		this.nombre = nombre;
		this.apellido = apellido;
		this.nombreDeUsuario = nombreUsuario;
		this.email = email;
	}
	
	new() {
	}
	
	
	def validarme() {
		this.validado = true;
	}
	
	def validarConstrasena(String contrasena){
		  if (contrasena != this.contrasena) {
                 throw new ContrasenaInvalidaException()
           }
	}
	
	def validarIngreso() {
    	if (!this.validado) {
        	throw new UsuarioNoValidadoException;
        }
	}
	
	override agregarReserva(Reserva unaReserva) {
		this.reservas.add(unaReserva)
	}
	
	override getReservas() {
		reservas
	}

	
}