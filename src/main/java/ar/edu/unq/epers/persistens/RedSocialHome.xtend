package ar.edu.unq.epers.persistens

import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.model.Relacion
import org.neo4j.graphdb.GraphDatabaseService
import org.neo4j.graphdb.DynamicLabel
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.ResourceIterator
import ar.edu.unq.epers.excepciones.NoExisteUsuarioEnRedSocialException
import org.neo4j.graphdb.Result
import ar.edu.unq.epers.services.GraphRunnerService

class RedSocialHome {
	
	GraphDatabaseService graph
	
	private def usuarioLabel() {
		DynamicLabel.label("Usuario")
	}
	
	def getGraphDb(){
		return GraphRunnerService.graphDb
	}
	
	def getUsuario(Usuario usuario1){
		var ResourceIterator<Node> ri = this.getGraphDb().findNodes(usuarioLabel, "nombreDeUsuario", usuario1.nombreDeUsuario)
		if(ri.isEmpty){
			System.out.println(ri.head)
			throw new NoExisteUsuarioEnRedSocialException
		}else{
			ri.head
		}
	}
	
	def crearNodo(Usuario usuario){
		val node = this.graphDb.createNode(usuarioLabel)
		node.setProperty("nombre", usuario.nombre)
		node.setProperty("apellido", usuario.apellido)
		node.setProperty("nombreDeUsuario", usuario.nombreDeUsuario)
		node.setProperty("email", usuario.email)	
	}
	
	def crearRelacionEntre(Usuario usuario1, Usuario usuario2, Relacion relacion) {
		val nodo1 = this.getUsuario(usuario1);
		val nodo2 = this.getUsuario(usuario2);
		nodo1.createRelationshipTo(nodo2, relacion);
	}
	
	def buscarRelacionDe(Usuario usuario, Relacion relacion) {
		var String q =  "MATCH (n) WHERE (n)-[:" + Relacion.AMISTAD + "]-({ nombreDeUsuario:'"+usuario.nombreDeUsuario+"' }) RETURN n";
		getGraphDb().execute(q)
	}
}