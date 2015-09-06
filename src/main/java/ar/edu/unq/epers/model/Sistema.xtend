package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList
import ar.edu.unq.epers.excepciones.UsuarioNoExisteException
import java.sql.Date
import ar.edu.unq.epers.excepciones.ContrasenaInvalidaException
import ar.edu.unq.epers.excepciones.UsuarioNoValidadoException

@Accessors 
class Sistema {
	
	List listaUsuarios;
	Home_Sistema homeSistema;
	
	new(){
		this.listaUsuarios = new ArrayList<Usuario>();
		this.homeSistema = new Home_Sistema();
	}
	
	/*Como usuario quiero poder registrarme cargando mis datos y que quede registrado en el sistema. Cuando el 
	usuario se registra debe enviar un mail al usuario para validar su cuenta. Para eso debe generarse un código
	 de validación que se envía por mail.
	*/
	
	def registrar(String NOMBRE, String APELLIDO, String NOMBRE_USUARIO, String EMAIL, Date FECHA_DE_NAC, String contrasena){
		val Usuario usuario = new Usuario(NOMBRE, APELLIDO, NOMBRE_USUARIO, EMAIL, FECHA_DE_NAC,contrasena);
		this.getListaUsuarios().add(usuario);
		this.getHomeSistema().guardarUsuario(usuario);	
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