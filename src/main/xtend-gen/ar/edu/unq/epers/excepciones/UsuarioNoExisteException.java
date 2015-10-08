package ar.edu.unq.epers.excepciones;

@SuppressWarnings("all")
public class UsuarioNoExisteException extends RuntimeException {
  @Override
  public String getMessage() {
    return "el usuario no existe";
  }
}
