/*

    Como usuario quiero poder agregar a mis amigos que ya son miembro del sitio.
    Como usuario quiero poder consultar a mis amigos
    Como usuario quiero poder mandar mensajes a mis amigos.
    Como usuario quiero poder saber todas las personas con las que estoy conectado, o sea mis amigos y los amigos de mis amigos recursivamente.

*/

package ar.edu.unq.epers.services

import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.persistens.RedSocialHome
import ar.edu.unq.epers.model.Relacion
import ar.edu.unq.epers.model.Mensaje
import java.util.List
import java.util.ArrayList
import ar.edu.unq.epers.excepciones.NoSonAmigosException

class RedSocialService {
	
	RedSocialHome redSocialHome
	
	new(RedSocialHome redSHome) {
		this.redSocialHome = redSHome
	}
	
	def agregarRelacionEntre(Usuario u1,Usuario u2,Relacion rel){
		GraphRunnerService::run[
			this.redSocialHome.crearRelacionEntre(u1,u2,rel)
		]
	}
		
	def obtenerAmigosDe(Usuario u){
		GraphRunnerService::run[
			this.redSocialHome.buscarRelacionDe(u,Relacion.AMISTAD)
			null 
		]
	}
	
	def anadirUsuario(Usuario usuario) {
		GraphRunnerService::run[
			this.redSocialHome.crearNodo(usuario); 
			null
		]
	}
	
	def obtenerRelacionesDe(Usuario usuario, Relacion relacion) {
		GraphRunnerService::run[
			this.redSocialHome.buscarRelacionDe(usuario,relacion); 
		]
	}
	
	def obtenerMensajesDe(Usuario usuario, Relacion relacion) {
		GraphRunnerService::run[
			this.redSocialHome.buscarRelacionMensajeDe(usuario,relacion); 
		]
	}
	
	def mandarMensajeA(Usuario usuario1,Usuario usuario2,Mensaje mensaje){
		GraphRunnerService::run[
			var List<String> usuarios = new ArrayList<String>
			usuarios = redSocialHome.buscarRelacionDe(usuario1,Relacion.AMISTAD);
			if(usuarios.contains(usuario2.nombreDeUsuario)){
				this.redSocialHome.enviarMensaje( usuario1, usuario2,mensaje);
		    	return null	
			}else{
				throw new NoSonAmigosException(usuario2.nombreDeUsuario)
			}
		]
	}
	
	def conectadosDe(Usuario usuario) {
		GraphRunnerService::run[
			this.redSocialHome.listaDeAmigosDeUnUsuario(usuario); 
		]
	}
	
	def esAmigoDe(Usuario usuario1,Usuario usuario2){			
		this.obtenerRelacionesDe(usuario1,Relacion.AMISTAD).contains(usuario2.nombreDeUsuario)
		
	}
	
}