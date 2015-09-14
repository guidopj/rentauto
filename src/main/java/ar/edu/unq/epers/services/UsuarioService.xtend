package ar.edu.unq.epers.services

import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.excepciones.UsuarioNoExisteException
import java.sql.Date
import ar.edu.unq.epers.excepciones.ContrasenaInvalidaException
import ar.edu.unq.epers.mailing.IEnviadorDeMails
import ar.edu.unq.epers.mailing.EnviadorMail
import ar.edu.unq.epers.mailing.Mail
import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.persistens.UsuarioHome

@Accessors 
class UsuarioService{
	
	UsuarioHome homeUsuario;
	IEnviadorDeMails enviadorMail;
	
	new(){
		this.homeUsuario = new UsuarioHome();
		this.enviadorMail = new EnviadorMail();
	}
	
	/**
	 * Como usuario quiero poder registrarme cargando mis datos y que quede registrado en el sistema. Cuando el 
	   usuario se registra debe enviar un mail al usuario para validar su cuenta. Para eso debe generarse un código
	   de validación que se envía por mail.
	*/
	
	def registrar(String nombre, String apellido, String nombreUsuario, String email, Date fechaDeNac, String contrasena){
		val Usuario usuario = new Usuario(nombre, apellido, nombreUsuario, email, fechaDeNac,contrasena);
		val codVal = usuario.nombreDeUsuario + "1357";
		
		usuario.codigoValidacion = codVal;
		
		val Mail mail = this.crearMail(codVal,usuario.email);
		
		this.enviadorMail.enviarMail(mail);
		
		this.getHomeUsuario().guardarUsuario(usuario);
	}
	
	def private crearMail(String cod, String email){
		val Mail mail = new Mail();
		
		mail.body = cod;
		mail.subject = "codigo validacion";
		mail.to = email;
		mail.from = "rentauto";
		return mail;
	}
	
	def validarCuenta(String codigo){
		val Usuario usuario = this.getHomeUsuario().getUsuarioPorCodigoValidacion(codigo);
		if(usuario == null){
			throw new UsuarioNoExisteException();
		}else{
			usuario.validarme();
			this.getHomeUsuario().actualizarUsuario(usuario);
		}
	}
	
	
	def ingresarUsuario(String nombreUsuario, String contr){
		val Usuario usuario = this.getHomeUsuario().getUsuarioPorNombreUsuario(nombreUsuario);
		if(usuario == null){
			throw new UsuarioNoExisteException();
		}else{
			usuario.validarConstrasena(contr)
       		usuario.validarIngreso()
       		return usuario
		}
	}
	
	def cambiarContrasena(String nombreUsuario, String viejacontr, String nuevacontr){
		val Usuario usuario = this.getHomeUsuario().getUsuarioPorNombreUsuario(nombreUsuario);
		if(usuario == null){
			throw new UsuarioNoExisteException();
		}else{
			if(usuario.contrasena == viejacontr){
				usuario.contrasena = nuevacontr;
				this.getHomeUsuario().actualizarUsuario(usuario);
			}else{
				throw new ContrasenaInvalidaException();
			}
		}
	}
	
}