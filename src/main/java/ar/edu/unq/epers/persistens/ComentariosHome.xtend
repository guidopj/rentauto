package ar.edu.unq.epers.persistens

import ar.edu.unq.epers.model.Comentario
import ar.edu.unq.epers.mongodb.Collection
import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.model.Visibilidad

class ComentariosHome {
	
		Collection<Comentario> homeComentario;
	
	def insertarObjeto(Comentario comentario) {
		homeComentario.insert(comentario)
	}
	
	def getComentarios(Usuario usuario, Visibilidad visibilidad) {
//		homeComentario.find()
	}
	
	
	
}