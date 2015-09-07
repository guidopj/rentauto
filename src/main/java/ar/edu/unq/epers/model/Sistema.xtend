package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList
import ar.edu.unq.epers.excepciones.UsuarioNoExisteException
import java.sql.Date
import ar.edu.unq.epers.excepciones.ContrasenaInvalidaException
import ar.edu.unq.epers.excepciones.UsuarioNoValidadoException

@Accessors 
class Sistema{
	
	//List listaUsuarios;
	Home_Sistema homeSistema;
	IEnviadorDeMails enviadorMail;
	
	new(){
		//this.listaUsuarios = new ArrayList<Usuario>();
		this.homeSistema = new Home_Sistema();
		this.enviadorMail = new EnviadorMail();
	}
	
	/*Como usuario quiero poder registrarme cargando mis datos y que quede registrado en el sistema. Cuando el 
	usuario se registra debe enviar un mail al usuario para validar su cuenta. Para eso debe generarse un código
	 de validación que se envía por mail.
	*/
	
	def registrar(String NOMBRE, String APELLIDO, String NOMBRE_USUARIO, String EMAIL, Date FECHA_DE_NAC, String contrasena){
		val Usuario usuario = new Usuario(NOMBRE, APELLIDO, NOMBRE_USUARIO, EMAIL, FECHA_DE_NAC,contrasena);
		val cod_val = usuario.nombre_de_usuario + "1357";
		
		usuario.codigo_validacion = cod_val;
		//this.getListaUsuarios().add(usuario);
		
		val Mail mail = this.crearMail(cod_val,usuario.email);
		
		this.enviadorMail.enviarMail(mail);
		
		this.getHomeSistema().guardarUsuario(usuario);
	}
	
	def crearMail(String cod, String email){
		val Mail mail = new Mail();
		
		mail.body = cod;
		mail.subject = "codigo validacion";
		mail.to = email;
		mail.from = "rentauto";
		return mail;
	}
	
	def validarCuenta(String codigo){
		val Usuario usuario = this.getHomeSistema().getUsuarioPorCodigoValidacion(codigo) as Usuario;
		if(usuario == null){
			throw new UsuarioNoExisteException();
		}else{
			usuario.validarme();
			this.getHomeSistema().actualizarUsuario(usuario);
		}
	}
	
	
	def ingresarUsuario(String nombreUsuario, String contr){
		val Usuario usuario = this.getHomeSistema().getUsuarioPorNombreUsuario(nombreUsuario) as Usuario;
		if(usuario == null){
			throw new UsuarioNoExisteException();
		}else{
			if(usuario.contrasena != contr){
				throw new ContrasenaInvalidaException();
			}else{
				if(!usuario.validado){
					throw new UsuarioNoValidadoException();
				}else{
					return usuario;
				}
			}
		}
	}
	
	def cambiarContrasena(String nombreUsuario, String viejacontr, String nuevacontr){
		val Usuario usuario = this.getHomeSistema().getUsuarioPorNombreUsuario(nombreUsuario) as Usuario;
		if(usuario == null){
			throw new UsuarioNoExisteException();
		}else{
			if(usuario.contrasena == viejacontr){
				usuario.contrasena = nuevacontr;
				this.getHomeSistema().actualizarUsuario(usuario);
			}else{
				throw new ContrasenaInvalidaException();
			}
		}
	}
	
}