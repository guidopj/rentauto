package ar.edu.unq.epers.persistens

import ar.edu.unq.epers.model.Comentario
import ar.edu.unq.epers.mongodb.Collection
import ar.edu.unq.epers.mongodb.SistemDB
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.model.Visibilidad
import ar.edu.unq.epers.model.Usuario
import org.mongojack.DBQuery

@Accessors
class ComentariosHome {
	
	Collection<Comentario> comentarios;
	
	new(){
		this.comentarios = SistemDB.instance().collection(Comentario)
	}
	
	def insertarComentario(Comentario comentario) {
		this.comentarios.insert(comentario)
	}
	
	def coleccionComentarios(){
		this.comentarios.getMongoCollection()
	}
	
	def armarQuery(Visibilidad visibilidad, Usuario usuario){
		if(visibilidad.equals(Visibilidad.AMIGO)){
			DBQuery.or(DBQuery.is("visibilidad", Visibilidad.PUBLICO),DBQuery.is("visibilidad", Visibilidad.AMIGO))
		}else if(visibilidad.equals(Visibilidad.PRIVADO)){
			DBQuery.or(DBQuery.is("visibilidad", Visibilidad.PUBLICO),DBQuery.is("visibilidad", Visibilidad.AMIGO),DBQuery.is("visibilidad", Visibilidad.PRIVADO))
		}else{
			DBQuery.is("visibilidad", Visibilidad.PUBLICO)
		}
	}
	
	def traerComentarios(Visibilidad visibilidad, Usuario usuario) {
		var query = armarQuery(visibilidad,usuario)
		return coleccionComentarios.find(query).toArray
	}
}