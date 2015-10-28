package ar.edu.unq.epers.excepciones

class NoExisteUsuarioEnRedSocialException extends RuntimeException{
	override getMessage(){
		return "El usuario no existe en la Red Social"
	}	
}