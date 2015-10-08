package ar.edu.unq.epers.services;

import ar.edu.unq.epers.excepciones.ContrasenaInvalidaException;
import ar.edu.unq.epers.excepciones.UsuarioNoExisteException;
import ar.edu.unq.epers.mailing.EnviadorMail;
import ar.edu.unq.epers.mailing.IEnviadorDeMails;
import ar.edu.unq.epers.mailing.Mail;
import ar.edu.unq.epers.model.Usuario;
import ar.edu.unq.epers.persistens.UsuarioHome;
import com.google.common.base.Objects;
import java.sql.Date;
import org.eclipse.xtend.lib.annotations.Accessors;
import org.eclipse.xtext.xbase.lib.Pure;

@Accessors
@SuppressWarnings("all")
public class UsuarioService {
  private UsuarioHome homeUsuario;
  
  private IEnviadorDeMails enviadorMail;
  
  public UsuarioService() {
    UsuarioHome _usuarioHome = new UsuarioHome();
    this.homeUsuario = _usuarioHome;
    EnviadorMail _enviadorMail = new EnviadorMail();
    this.enviadorMail = _enviadorMail;
  }
  
  /**
   * Como usuario quiero poder registrarme cargando mis datos y que quede registrado en el sistema. Cuando el
   * usuario se registra debe enviar un mail al usuario para validar su cuenta. Para eso debe generarse un código
   * de validación que se envía por mail.
   */
  public Boolean registrar(final String nombre, final String apellido, final String nombreUsuario, final String email, final Date fechaDeNac, final String contrasena) {
    Boolean _xblockexpression = null;
    {
      final Usuario usuario = new Usuario(nombre, apellido, nombreUsuario, email, fechaDeNac, contrasena);
      String _nombreDeUsuario = usuario.getNombreDeUsuario();
      final String codVal = (_nombreDeUsuario + "1357");
      usuario.setCodigoValidacion(codVal);
      String _email = usuario.getEmail();
      final Mail mail = this.crearMail(codVal, _email);
      this.enviadorMail.enviarMail(mail);
      UsuarioHome _homeUsuario = this.getHomeUsuario();
      _xblockexpression = _homeUsuario.guardarUsuario(usuario);
    }
    return _xblockexpression;
  }
  
  private Mail crearMail(final String cod, final String email) {
    final Mail mail = new Mail();
    mail.setBody(cod);
    mail.setSubject("codigo validacion");
    mail.setTo(email);
    mail.setFrom("rentauto");
    return mail;
  }
  
  public Boolean validarCuenta(final String codigo) {
    Boolean _xblockexpression = null;
    {
      UsuarioHome _homeUsuario = this.getHomeUsuario();
      final Usuario usuario = _homeUsuario.getUsuarioPorCodigoValidacion(codigo);
      Boolean _xifexpression = null;
      boolean _equals = Objects.equal(usuario, null);
      if (_equals) {
        throw new UsuarioNoExisteException();
      } else {
        Boolean _xblockexpression_1 = null;
        {
          usuario.validarme();
          UsuarioHome _homeUsuario_1 = this.getHomeUsuario();
          _xblockexpression_1 = _homeUsuario_1.actualizarUsuario(usuario);
        }
        _xifexpression = _xblockexpression_1;
      }
      _xblockexpression = _xifexpression;
    }
    return _xblockexpression;
  }
  
  public Usuario ingresarUsuario(final String nombreUsuario, final String contr) {
    UsuarioHome _homeUsuario = this.getHomeUsuario();
    final Usuario usuario = _homeUsuario.getUsuarioPorNombreUsuario(nombreUsuario);
    boolean _equals = Objects.equal(usuario, null);
    if (_equals) {
      throw new UsuarioNoExisteException();
    } else {
      usuario.validarConstrasena(contr);
      usuario.validarIngreso();
      return usuario;
    }
  }
  
  public Boolean cambiarContrasena(final String nombreUsuario, final String viejacontr, final String nuevacontr) {
    Boolean _xblockexpression = null;
    {
      UsuarioHome _homeUsuario = this.getHomeUsuario();
      final Usuario usuario = _homeUsuario.getUsuarioPorNombreUsuario(nombreUsuario);
      Boolean _xifexpression = null;
      boolean _equals = Objects.equal(usuario, null);
      if (_equals) {
        throw new UsuarioNoExisteException();
      } else {
        Boolean _xifexpression_1 = null;
        String _contrasena = usuario.getContrasena();
        boolean _equals_1 = Objects.equal(_contrasena, viejacontr);
        if (_equals_1) {
          Boolean _xblockexpression_1 = null;
          {
            usuario.setContrasena(nuevacontr);
            UsuarioHome _homeUsuario_1 = this.getHomeUsuario();
            _xblockexpression_1 = _homeUsuario_1.actualizarUsuario(usuario);
          }
          _xifexpression_1 = _xblockexpression_1;
        } else {
          throw new ContrasenaInvalidaException();
        }
        _xifexpression = _xifexpression_1;
      }
      _xblockexpression = _xifexpression;
    }
    return _xblockexpression;
  }
  
  @Pure
  public UsuarioHome getHomeUsuario() {
    return this.homeUsuario;
  }
  
  public void setHomeUsuario(final UsuarioHome homeUsuario) {
    this.homeUsuario = homeUsuario;
  }
  
  @Pure
  public IEnviadorDeMails getEnviadorMail() {
    return this.enviadorMail;
  }
  
  public void setEnviadorMail(final IEnviadorDeMails enviadorMail) {
    this.enviadorMail = enviadorMail;
  }
}
