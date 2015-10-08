package ar.edu.unq.epers.model;

import ar.edu.unq.epers.model.Reserva;
import java.util.List;

@SuppressWarnings("all")
public interface IUsuario {
  public abstract void agregarReserva(final Reserva unaReserva);
  
  public abstract List<Reserva> getReservas();
}
