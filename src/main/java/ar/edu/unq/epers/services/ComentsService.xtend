package ar.edu.unq.epers.services


import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.model.Visibilidad
import ar.edu.unq.epers.model.Calificacion
import ar.edu.unq.epers.model.Comentario
import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.mongodb.Collection
import ar.edu.unq.epers.persistens.ComentariosHome
import java.util.List
import java.util.ArrayList

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
			var List<Visibilidad> v1 = new ArrayList<Visibilidad>()
			v1.add(Visibilidad.PUBLICO) 
			homeComentario.getComentarios(usuario1,v1)
		}else if(this.esVisible(usuario1,usuario2)){
			var List<Visibilidad> v2 = new ArrayList<Visibilidad>()
			v2.add(Visibilidad.PRIVADO)
			v2.add(Visibilidad.AMIGOS)
			homeComentario.getComentarios(usuario2,v2)
		}else{
			var List<Visibilidad> v3 = new ArrayList<Visibilidad>
			v3.add(Visibilidad.PUBLICO)
			v3.add(Visibilidad.AMIGOS)
			v3.add(Visibilidad.PRIVADO)
			homeComentario.getComentarios(usuario1,v3)
			}
		}

}