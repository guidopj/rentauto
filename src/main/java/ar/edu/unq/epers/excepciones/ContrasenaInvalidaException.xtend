package ar.edu.unq.epers.excepciones

class ContrasenaInvalidaException extends RuntimeException{
	
	override getMessage(){
		return "contraseña invalida";
	}
	
}