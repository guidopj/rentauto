package ar.edu.unq.epers.services


import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Visibilidad
import ar.edu.unq.epers.model.Calificacion
import ar.edu.unq.epers.model.Comentario
import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.mongodb.Collection
import ar.edu.unq.epers.persistens.ComentariosHome

class ComentsService {
	
	ComentariosHome homeComentario
	RedSocialService redSocial
	
	
	new(ComentariosHome homeComentario,RedSocialService redSocial) {
		this.homeComentario = homeComentario
		this.redSocial = redSocial
		
	}
	
	
	def hacerComentario(Auto auto,Visibilidad visibilidad,Calificacion calificacion,String comentario,Usuario user){
		
		var Comentario newComentario = new Comentario(auto,visibilidad,calificacion,comentario,user)
		homeComentario.insertarObjeto(newComentario)	
	}
	def esVisible(Usuario usuario1,Usuario usuario2){
		return redSocial.esAmigoDe(usuario1,usuario2)
	}
	def verComentarios(Usuario usuario1,Usuario usuario2){
		if (usuario1.nombreDeUsuario.equals(usuario2.nombreDeUsuario)){
			homeComentario.getComentarios(usuario1,Visibilidad.PRIVADO)
		}else if(this.esVisible(usuario1,usuario2)){
			homeComentario.getComentarios(usuario2,Visibilidad.AMIGOS)
		}else{homeComentario.getComentarios(usuario1,Visibilidad.PUBLICO)
			}
		}

}