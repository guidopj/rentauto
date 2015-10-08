package ar.edu.unq.epers.mailing;

import ar.edu.unq.epers.mailing.Mail;

@SuppressWarnings("all")
public interface IEnviadorDeMails {
  public abstract void enviarMail(final Mail mail);
}
