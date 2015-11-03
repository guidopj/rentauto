package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Mensaje {
	
	Usuario remitente
	Usuario destinatario
	String asunto
	String contenido

	new(){}
	
	new(Usuario remitente, Usuario destinatario, String asunto, String contenido) {
		this.remitente = remitente;
		this.destinatario = destinatario;
		this.asunto = asunto;
		this.contenido = contenido;
		 
    }
   
}