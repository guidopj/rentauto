package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Mensaje {
	
	String emisor
	String receptor
	String asunto
	String contenido

	new(){}
	
	new(String emisor, String receptor,String asunto, String contenido) {
		this.emisor = emisor
		this.receptor = receptor 
		this.asunto = asunto;
		this.contenido = contenido;
		 
    }
   
}