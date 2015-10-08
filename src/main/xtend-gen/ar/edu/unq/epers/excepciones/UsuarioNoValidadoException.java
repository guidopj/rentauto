package ar.edu.unq.epers.excepciones;

@SuppressWarnings("all")
public class UsuarioNoValidadoException extends RuntimeException {
  @Override
  public String getMessage() {
    return "el usuario no ha sido validado";
  }
}
