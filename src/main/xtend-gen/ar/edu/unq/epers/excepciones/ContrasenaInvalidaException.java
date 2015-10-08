package ar.edu.unq.epers.excepciones;

@SuppressWarnings("all")
public class ContrasenaInvalidaException extends RuntimeException {
  @Override
  public String getMessage() {
    return "contraseña invalida";
  }
}
