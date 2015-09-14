package ar.edu.unq.epers.excepciones

class ConexionFallidaException extends RuntimeException{
	
	override getMessage(){
		return "hubo una falla con la conexion a la base de datos"
	}
}