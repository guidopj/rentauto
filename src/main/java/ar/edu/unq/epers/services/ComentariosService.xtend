package ar.edu.unq.epers.services

import ar.edu.unq.epers.model.Visibilidad
import ar.edu.unq.epers.model.Calificacion
import ar.edu.unq.epers.model.Comentario
import ar.edu.unq.epers.model.Usuario
import ar.edu.unq.epers.persistens.ComentariosHome
import ar.edu.unq.epers.model.Auto

class ComentariosService {
	
	ComentariosHome homeComentario
	RedSocialService redSocial
	
	
	new(ComentariosHome homeComentario,RedSocialService redSocial) {
		this.homeComentario = homeComentario
		this.redSocial = redSocial
	}

	def hacerComentario(String patenteAuto,Visibilidad visibilidad,Calificacion calificacion,String comentario,Usuario user){
		var Comentario newComentario = new Comentario(patenteAuto,visibilidad,calificacion,comentario,user)
		homeComentario.insertarComentario(newComentario)	
	}
	
	
	def sonAmigos(Usuario usuario1,Usuario usuario2){
		return redSocial.esAmigoDe(usuario1,usuario2)
	}
	
	//Como usuario quiero 
	//poder ver el perfil público de otro usuario, viendo lo que me corresponde según si soy amigo o no.
	
	def soyYo(Usuario usuario1,Usuario usuario2){
		usuario1.nombreDeUsuario.equals(usuario2.nombreDeUsuario)
	}
	
	def verPerfilDe(Usuario usuario1, Usuario usuario2){
		if(soyYo(usuario1,usuario2)){
			homeComentario.traerComentarios(Visibilidad.PRIVADO,usuario2)
		}else if (sonAmigos(usuario1,usuario2)){
			homeComentario.traerComentarios(Visibilidad.AMIGO,usuario2)
		}else{
			homeComentario.traerComentarios(Visibilidad.PUBLICO,usuario2)
		}
	}
}