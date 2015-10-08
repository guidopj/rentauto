package ar.edu.unq.epers.persistens;

import ar.edu.unq.epers.model.Auto;
import ar.edu.unq.epers.model.Categoria;
import ar.edu.unq.epers.sesiones.SessionManager;
import java.io.Serializable;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

@SuppressWarnings("all")
public class AutoHome {
  public <T extends Object> Serializable guardar(final T element) {
    Session _session = SessionManager.getSession();
    return _session.save(element);
  }
  
  public <T extends Object> void borrar(final T element) {
    Session _session = SessionManager.getSession();
    _session.delete(element);
  }
  
  public Auto obtenerAuto(final int id) {
    Session _session = SessionManager.getSession();
    Object _get = _session.get(Auto.class, Integer.valueOf(id));
    return ((Auto) _get);
  }
  
  public List<Auto> obtenerAutos() {
    Session _session = SessionManager.getSession();
    Query q = _session.createQuery("from Auto");
    List<Auto> todos = q.list();
    return ((List<Auto>) todos);
  }
  
  public List<Auto> obtenerAutosPorCategoria(final Categoria categoria) {
    Session _session = SessionManager.getSession();
    Query q = _session.createQuery("from Auto as auto where auto.categoria.nombre = :cat");
    String _nombre = categoria.getNombre();
    q.setString("cat", _nombre);
    List<Auto> todos = q.list();
    return ((List<Auto>) todos);
  }
}
