package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Comentario {
	
	Calificacion calificacion
	String comentario
	Visibilidad visibilidad
	Auto auto
	Usuario user
	
	new() {
		
	}
	
	
	new (Auto auto,Visibilidad visibilidad,Calificacion calificacion,String comentario,Usuario user) {
		this.auto = auto
		this.visibilidad = visibilidad
		this.calificacion = calificacion
		this.comentario = comentario
		this.user = user
	}
	
	
}