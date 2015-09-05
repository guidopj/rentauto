package ar.edu.unq.epers.excepciones

class UsuarioNoExisteException extends RuntimeException{
	override getMessage(){
		return "el usuario no existe";
	}
}