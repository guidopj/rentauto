package ar.edu.unq.epers.excepciones

class NoSonAmigosException extends RuntimeException{
	
	String usr
	
	new(String usuario) {
		this.usr = usuario
	}
	
	override getMessage(){
		return "Debes ser amigo de " + usr + " para poder enviarle un mensaje"
	}
}