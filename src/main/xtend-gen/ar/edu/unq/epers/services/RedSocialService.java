/**
 * Como usuario quiero poder agregar a mis amigos que ya son miembro del sitio.
 * Como usuario quiero poder consultar a mis amigos
 * Como usuario quiero poder mandar mensajes a mis amigos.
 * Como usuario quiero poder saber todas las personas con las que estoy conectado, o sea mis amigos y los amigos de mis amigos recursivamente.
 */
package ar.edu.unq.epers.services;

import ar.edu.unq.epers.model.Relacion;
import ar.edu.unq.epers.model.Usuario;
import ar.edu.unq.epers.persistens.RedSocialHome;
import ar.edu.unq.epers.services.GraphRunnerService;
import org.eclipse.xtext.xbase.lib.Functions.Function1;
import org.neo4j.graphdb.GraphDatabaseService;
import org.neo4j.graphdb.Relationship;

@SuppressWarnings("all")
public class RedSocialService {
  private GraphDatabaseService graph;
  
  private RedSocialHome redSocialHome;
  
  public RedSocialService(final RedSocialHome redSHome) {
    this.redSocialHome = redSHome;
  }
  
  public Relationship agregarRelacionEntre(final Usuario u1, final Usuario u2, final Relacion rel) {
    final Function1<GraphDatabaseService, Relationship> _function = new Function1<GraphDatabaseService, Relationship>() {
      @Override
      public Relationship apply(final GraphDatabaseService it) {
        return RedSocialService.this.redSocialHome.crearRelacionEntre(u1, u2, rel);
      }
    };
    return GraphRunnerService.<Relationship>run(_function);
  }
  
  public Object anadirUsuario(final Usuario usuario) {
    final Function1<GraphDatabaseService, Object> _function = new Function1<GraphDatabaseService, Object>() {
      @Override
      public Object apply(final GraphDatabaseService it) {
        Object _xblockexpression = null;
        {
          RedSocialService.this.redSocialHome.crearNodo(usuario);
          _xblockexpression = null;
        }
        return _xblockexpression;
      }
    };
    return GraphRunnerService.<Object>run(_function);
  }
}
