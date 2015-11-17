package ar.edu.unq.epers.persistens


import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.model.Mensaje
import ar.edu.unq.epers.model.Relacion
import org.neo4j.graphdb.DynamicLabel
import org.neo4j.graphdb.Node
import org.neo4j.graphdb.ResourceIterator
import ar.edu.unq.epers.excepciones.NoExisteUsuarioEnRedSocialException
import org.neo4j.graphdb.Result
import ar.edu.unq.epers.services.GraphRunnerService
import org.neo4j.graphdb.traversal.Evaluators
import java.util.List
import java.util.ArrayList
import org.neo4j.graphdb.Relationship
import org.neo4j.graphdb.Path


class RedSocialHome {
	

	private def miLabel(String label){
		DynamicLabel.label(label)
	}
	 
	def getGraphDb(){
		return GraphRunnerService.graphDb
	}
	
	def nodeUsuario(Usuario usuario1){
		// Mediante este metodo se crea un nodo para determinado usuario.
		var ResourceIterator<Node> ri = this.getGraphDb().findNodes(miLabel("Usuario"), "nombreDeUsuario", usuario1.nombreDeUsuario)
		if(ri.isEmpty){
			throw new NoExisteUsuarioEnRedSocialException
		}else{
			ri.head
		}
	}
	
	def crearNodo(Usuario usuario){
		val node = this.graphDb.createNode(miLabel("Usuario"))
		node.setProperty("nombre", usuario.nombre)
		node.setProperty("apellido", usuario.apellido)
		node.setProperty("nombreDeUsuario", usuario.nombreDeUsuario)
		node.setProperty("email", usuario.email)
		node
	}
	
	def crearNodoMensaje(Mensaje mensaje){
		val node = this.graphDb.createNode(miLabel("Mensaje"))
		node.setProperty("emisor", mensaje.emisor)
		node.setProperty("receptor", mensaje.receptor)
		node.setProperty("asunto", mensaje.asunto)
		node.setProperty("contenido", mensaje.contenido)
		node
	}
	
	def crearRelacionEntre(Usuario usuario1, Usuario usuario2, Relacion relacion) {
		val nodo1 = this.nodeUsuario(usuario1);
		val nodo2 = this.nodeUsuario(usuario2);
		nodo1.createRelationshipTo(nodo2, relacion);
		
	}
	
	def enviarMensaje(Usuario usuario1, Usuario usuario2, Mensaje mensaje) {
		val nodo1 = this.nodeUsuario(usuario1);
		val nodo2 = this.nodeUsuario(usuario2);
		val nodoMensaje = this.crearNodoMensaje(mensaje);
		nodo1.createRelationshipTo(nodoMensaje, Relacion.EMISOR)
		nodo2.createRelationshipTo(nodoMensaje,Relacion.RECEPTOR)
//		var Relationship r = nodo1.createRelationshipTo(nodo2,Relacion.MENSAJE)
//		r.setProperty("asunto",mensaje.asunto)
//		r.setProperty("contenido",mensaje.contenido)
	}
	
	
	def buscarRelacionDe(Usuario usuario, Relacion relacion) {
		var List<String> resultedList = new ArrayList<String>
		
		var String q =  "MATCH (n) WHERE (n)-[:" + relacion + "]-({ nombreDeUsuario:'"+usuario.nombreDeUsuario+"' }) RETURN n";
		var Result res = getGraphDb().execute(q)
		
		var ResourceIterator<Node> userData = res.columnAs("n")
		while(userData.hasNext){
			resultedList.add(userData.next.getProperty("nombreDeUsuario")as String)
		}
		resultedList
	}
	
	def buscarRelacionMensajeDe(Usuario usuario, Relacion relacion) {
		var List<Mensaje> resultedList = new ArrayList<Mensaje>
		
		var Node nodoUsuario = nodeUsuario(usuario)
		
		var List<Relationship> relaciones = nodoUsuario.getRelationships(relacion).toList
		
		for(Relationship rel : relaciones){
			resultedList.add(crearMensajeDeNodo(rel.getOtherNode(nodoUsuario)))
		}
		resultedList
	}
	
	
	def crearUsuarioDeNodo(Node node){
	   var Usuario user = new Usuario
	   user.nombre = node.getProperty("nombre")as String
	   user.apellido = node.getProperty("apellido")as String
	   user.email = node.getProperty("email")as String
	   user.nombreDeUsuario = node.getProperty("nombreDeUsuario")as String
	   return user
	}
	
	def crearMensajeDeNodo(Node node){
	   var Mensaje msj= new Mensaje
	   msj.emisor= node.getProperty("emisor")as String
	   msj.receptor = node.getProperty("receptor")as String
	   msj.asunto = node.getProperty("asunto")as String
	   msj.contenido = node.getProperty("contenido")as String
	   return msj
	}
	
	
	def  listaDeAmigosDeUnUsuario(Usuario usuario){
		var Node n = this.nodeUsuario(usuario)
		graphDb.traversalDescription()
	        .breadthFirst()
	        .relationships(Relacion.AMISTAD)
	        .evaluator(Evaluators.excludeStartPosition)
	        .traverse(n)
	        .nodes()
	        .map[it.getProperty("nombre")].toSet
	   	}
	   	
	   	
	 def agregarConectados(Path p, List<String> listaResultado){
	 	for(Node nodo : p.nodes()){
	    	listaResultado.add(this.crearUsuarioDeNodo(nodo).nombreDeUsuario)
	    }
	 }

	
	/***
	 * Por cada nodo que se recorre con su respectivo usuario, se agrega a una lista
	 * cada uno de esos usuarios y a sus respectivos amigos. Una vez hecho todo esto,
	 * se retorna dicha lista con todos los amigos de determiando usuario, y los amigos
	 * de sus amigos y asi recursivamente.
	 ***/ 
	
}