package ar.edu.unq.epers.excepciones

class EnviarMailException extends RuntimeException{
	
	override getMessage(){
		return "mail error!"
	}
}