package ar.edu.unq.epers.excepciones;

@SuppressWarnings("all")
public class EnviarMailException extends RuntimeException {
  @Override
  public String getMessage() {
    return "mail error!";
  }
}
