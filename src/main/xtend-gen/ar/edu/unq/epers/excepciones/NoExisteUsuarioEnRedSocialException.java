package ar.edu.unq.epers.excepciones;

@SuppressWarnings("all")
public class NoExisteUsuarioEnRedSocialException extends RuntimeException {
  @Override
  public String getMessage() {
    return "El usuario no existe en la Red Social";
  }
}
