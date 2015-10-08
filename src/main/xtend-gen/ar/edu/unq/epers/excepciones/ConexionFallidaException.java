package ar.edu.unq.epers.excepciones;

@SuppressWarnings("all")
public class ConexionFallidaException extends RuntimeException {
  @Override
  public String getMessage() {
    return "hubo una falla con la conexion a la base de datos";
  }
}
