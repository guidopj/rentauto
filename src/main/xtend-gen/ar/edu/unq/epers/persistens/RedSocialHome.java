package ar.edu.unq.epers.persistens;

import ar.edu.unq.epers.excepciones.NoExisteUsuarioEnRedSocialException;
import ar.edu.unq.epers.model.Relacion;
import ar.edu.unq.epers.model.Usuario;
import org.eclipse.xtext.xbase.lib.IteratorExtensions;
import org.neo4j.graphdb.DynamicLabel;
import org.neo4j.graphdb.GraphDatabaseService;
import org.neo4j.graphdb.Label;
import org.neo4j.graphdb.Node;
import org.neo4j.graphdb.Relationship;
import org.neo4j.graphdb.ResourceIterator;

@SuppressWarnings("all")
public class RedSocialHome {
  private GraphDatabaseService graph;
  
  public RedSocialHome(final GraphDatabaseService graph) {
    this.graph = graph;
  }
  
  private Label usuarioLabel() {
    return DynamicLabel.label("Usuario");
  }
  
  public Node getUsuario(final Usuario usuario1) {
    Node _xblockexpression = null;
    {
      Label _usuarioLabel = this.usuarioLabel();
      String _nombreDeUsuario = usuario1.getNombreDeUsuario();
      ResourceIterator<Node> ri = this.graph.findNodes(_usuarioLabel, "nombreDeUsuario", _nombreDeUsuario);
      Node _xifexpression = null;
      boolean _isEmpty = IteratorExtensions.isEmpty(ri);
      if (_isEmpty) {
        throw new NoExisteUsuarioEnRedSocialException();
      } else {
        _xifexpression = IteratorExtensions.<Node>head(ri);
      }
      _xblockexpression = _xifexpression;
    }
    return _xblockexpression;
  }
  
  public void crearNodo(final Usuario usuario) {
    Label _usuarioLabel = this.usuarioLabel();
    final Node node = this.graph.createNode(_usuarioLabel);
    String _nombre = usuario.getNombre();
    node.setProperty("nombre", _nombre);
    String _apellido = usuario.getApellido();
    node.setProperty("apellido", _apellido);
    String _nombreDeUsuario = usuario.getNombreDeUsuario();
    node.setProperty("nombreDeUsuario", _nombreDeUsuario);
    String _email = usuario.getEmail();
    node.setProperty("email", _email);
  }
  
  public Relationship crearRelacionEntre(final Usuario usuario1, final Usuario usuario2, final Relacion relacion) {
    Relationship _xblockexpression = null;
    {
      final Node nodo1 = this.getUsuario(usuario1);
      final Node nodo2 = this.getUsuario(usuario2);
      _xblockexpression = nodo1.createRelationshipTo(nodo2, relacion);
    }
    return _xblockexpression;
  }
}
