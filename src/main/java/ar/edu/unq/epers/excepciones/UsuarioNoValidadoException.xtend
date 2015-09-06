package ar.edu.unq.epers.excepciones

class UsuarioNoValidadoException extends RuntimeException{
	
	override getMessage(){
		return "el usuario no ha sido validado"
	}
}