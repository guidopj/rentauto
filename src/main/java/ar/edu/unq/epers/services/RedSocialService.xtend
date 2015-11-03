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
import org.neo4j.graphdb.Path
import org.neo4j.cypher.internal.compiler.v2_3.functions.Rels
import org.neo4j.graphdb.Direction
import org.neo4j.graphdb.traversal.Evaluators

class RedSocialService {
	
	RedSocialHome redSocialHome
	
	new(RedSocialHome redSHome) {
		//this.graph = graph
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
			return null 
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
	
	def mandarMensajeA(Usuario usuario1,Usuario usuario2,Mensaje mensaje){
		GraphRunnerService::run[
			this.redSocialHome.crearNodoMensaje(mensaje);
			this.redSocialHome.crearRelacionUsuarioMensaje(usuario1,mensaje,Relacion.EMISOR);
			this.redSocialHome.crearRelacionUsuarioMensaje(usuario2,mensaje,Relacion.RECEPTOR);
		    return null
		]
	}
	
}