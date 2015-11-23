package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors
import com.mongodb.DBObject
import org.bson.BSONObject
import java.util.Map

@Accessors
class Comentario{
	
	String _id;
	Calificacion calificacion
	String comentario
	Visibilidad visibilidad
	String patenteAuto
	Usuario user
	
	new() {
		
	}
	
//	new (String patenteAuto,Visibilidad visibilidad,Calificacion calificacion,String comentario,Usuario user) {
//		this.patenteAuto = patenteAuto
//		this.visibilidad = visibilidad
//		this.calificacion = calificacion
//		this.comentario = comentario
//		this.user = user
//	}
	
	new (String patenteAuto,Visibilidad visibilidad,Calificacion calificacion,String comentario,Usuario user) {
		this.patenteAuto = patenteAuto
		this.visibilidad = visibilidad
		this.calificacion = calificacion
		this.comentario = comentario
		this.user = user
	}
}