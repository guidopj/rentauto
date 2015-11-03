package ar.edu.unq.epers.persistens


import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.model.Mensaje
import ar.edu.unq.epers.model.Relacion
import org.neo4j.graphdb.GraphDatabaseService
import org.neo4j.graphdb.DynamicLabel
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.ResourceIterator
import ar.edu.unq.epers.excepciones.NoExisteUsuarioEnRedSocialException
import org.neo4j.graphdb.Result
import ar.edu.unq.epers.services.GraphRunnerService
import org.neo4j.graphdb.traversal.Evaluators
import java.util.List
import java.util.ArrayList

class RedSocialHome {
	
	GraphDatabaseService graph
	List<Usuario> usuarios = newArrayList
	
	private def usuarioLabel() {
		DynamicLabel.label("Usuario")
	}
	
	private def mensajeLabel(){
		DynamicLabel.label("Mensaje")
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
	
	def crearNodoMensaje(Mensaje mensaje){
		val node = this.graphDb.createNode(mensajeLabel)
		node.setProperty("remitente", mensaje.remitente)
		node.setProperty("destinatario", mensaje.destinatario)
		node.setProperty("asunto", mensaje.asunto)
		node.setProperty("contenido", mensaje.contenido)
		node	
	}
	
	def crearRelacionEntre(Usuario usuario1, Usuario usuario2, Relacion relacion) {
		val nodo1 = this.getUsuario(usuario1);
		val nodo2 = this.getUsuario(usuario2);
		nodo1.createRelationshipTo(nodo2, relacion);
		
	}
	
	
	def crearRelacionUsuarioMensaje(Usuario usuario1,Mensaje mensaje , Relacion relacion) {
		val nodo1 = this.getUsuario(usuario1);
		val nodo2 = this.crearNodoMensaje(mensaje);
		nodo1.createRelationshipTo(nodo2, relacion);
		
	}
	
	
	def buscarRelacionDe(Usuario usuario, Relacion relacion) {
		var String q =  "MATCH (n) WHERE (n)-[:" + Relacion.AMISTAD + "]-({ nombreDeUsuario:'"+usuario.nombreDeUsuario+"' }) RETURN n";
		getGraphDb().execute(q)
	}
	
	
	def crearUsuarioDeNodo(Node node){
	   
	   var Usuario user = new Usuario
	   user.nombre = node.getProperty("nombre")as String
	   user.apellido = node.getProperty("apellido")as String
	   return user
	}
	
	
	def listaDeAmigosDeUnUsuario(Usuario usuario){
	//nodo =  getNodoDeUsuario de este usuario
	var List<Usuario> usuarios = new ArrayList<Usuario>();
	var Node n = this.getUsuario(usuario)
	graphDb.traversalDescription()
	        .depthFirst()
	        .relationships(Relacion.AMISTAD)
	        .evaluator( Evaluators.excludeStartPosition)
	        .traverse(n)
	        //.nodes().map[ usuarios.add(this.crearUsuarioDeNodo(it))]
	}
	
}