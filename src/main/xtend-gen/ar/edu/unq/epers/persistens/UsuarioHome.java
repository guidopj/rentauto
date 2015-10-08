package ar.edu.unq.epers.persistens;

import ar.edu.unq.epers.excepciones.ConexionFallidaException;
import ar.edu.unq.epers.model.Usuario;
import com.google.common.base.Objects;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.eclipse.xtext.xbase.lib.Exceptions;
import org.eclipse.xtext.xbase.lib.Functions.Function1;

@SuppressWarnings("all")
public class UsuarioHome {
  public <T extends Object> T queryDb(final Function1<Connection, T> bloque) {
    try {
      Connection conn = null;
      try {
        Connection _connection = this.getConnection();
        conn = _connection;
        return bloque.apply(conn);
      } catch (final Throwable _t) {
        if (_t instanceof SQLException) {
          final SQLException e = (SQLException)_t;
          throw new ConexionFallidaException();
        } else {
          throw Exceptions.sneakyThrow(_t);
        }
      } finally {
        boolean _notEquals = (!Objects.equal(conn, null));
        if (_notEquals) {
          conn.close();
        }
      }
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  private Usuario construirUsuario(final ResultSet rs) {
    try {
      final Usuario usuario = new Usuario();
      String _string = rs.getString("NOMBRE");
      usuario.setNombre(_string);
      String _string_1 = rs.getString("APELLIDO");
      usuario.setApellido(_string_1);
      String _string_2 = rs.getString("NOMBRE_USUARIO");
      usuario.setNombreDeUsuario(_string_2);
      String _string_3 = rs.getString("EMAIL");
      usuario.setEmail(_string_3);
      Date _date = rs.getDate("FECHA_DE_NAC");
      usuario.setFechaDeNac(_date);
      boolean _boolean = rs.getBoolean("VALIDADO");
      usuario.setValidado(Boolean.valueOf(_boolean));
      String _string_4 = rs.getString("CONTRASENA");
      usuario.setContrasena(_string_4);
      return usuario;
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
  
  public Usuario getUsuarioPorCodigoValidacion(final String cod) {
    final Function1<Connection, Usuario> _function = new Function1<Connection, Usuario>() {
      @Override
      public Usuario apply(final Connection conn) {
        try {
          PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM Usuarios_Codigo_Validacion NATURAL JOIN Usuarios where CODIGO_VALIDACION = ?");
          ps1.setString(1, cod);
          ResultSet rs = ps1.executeQuery();
          boolean _next = rs.next();
          if (_next) {
            final Usuario usuario = UsuarioHome.this.construirUsuario(rs);
            ps1.close();
            return usuario;
          } else {
            ps1.close();
            return null;
          }
        } catch (Throwable _e) {
          throw Exceptions.sneakyThrow(_e);
        }
      }
    };
    return this.<Usuario>queryDb(_function);
  }
  
  public Usuario getUsuarioPorNombreUsuario(final String nombreUsuario) {
    final Function1<Connection, Usuario> _function = new Function1<Connection, Usuario>() {
      @Override
      public Usuario apply(final Connection conn) {
        try {
          PreparedStatement ps1 = conn.prepareStatement("SELECT * FROM  Usuarios where NOMBRE_USUARIO = ?");
          ps1.setString(1, nombreUsuario);
          ResultSet rs = ps1.executeQuery();
          boolean _next = rs.next();
          if (_next) {
            final Usuario usuario = UsuarioHome.this.construirUsuario(rs);
            ps1.close();
            return usuario;
          } else {
            ps1.close();
            return null;
          }
        } catch (Throwable _e) {
          throw Exceptions.sneakyThrow(_e);
        }
      }
    };
    return this.<Usuario>queryDb(_function);
  }
  
  public Boolean actualizarUsuario(final Usuario usuario) {
    final Function1<Connection, Boolean> _function = new Function1<Connection, Boolean>() {
      @Override
      public Boolean apply(final Connection conn) {
        try {
          boolean _xblockexpression = false;
          {
            String sql = "UPDATE Usuarios set NOMBRE=?, APELLIDO=?, EMAIL = ?, FECHA_DE_NAC = ?, VALIDADO = ?, CONTRASENA = ? where NOMBRE_USUARIO=?";
            final PreparedStatement ps1 = conn.prepareStatement(sql);
            String _nombre = usuario.getNombre();
            ps1.setString(1, _nombre);
            String _apellido = usuario.getApellido();
            ps1.setString(2, _apellido);
            String _email = usuario.getEmail();
            ps1.setString(3, _email);
            Date _fechaDeNac = usuario.getFechaDeNac();
            ps1.setDate(4, _fechaDeNac);
            Boolean _validado = usuario.getValidado();
            ps1.setBoolean(5, (_validado).booleanValue());
            String _contrasena = usuario.getContrasena();
            ps1.setString(6, _contrasena);
            String _nombreDeUsuario = usuario.getNombreDeUsuario();
            ps1.setString(7, _nombreDeUsuario);
            _xblockexpression = ps1.execute();
          }
          return Boolean.valueOf(_xblockexpression);
        } catch (Throwable _e) {
          throw Exceptions.sneakyThrow(_e);
        }
      }
    };
    return this.<Boolean>queryDb(_function);
  }
  
  public Boolean guardarUsuario(final Usuario usuario) {
    final Function1<Connection, Boolean> _function = new Function1<Connection, Boolean>() {
      @Override
      public Boolean apply(final Connection conn) {
        try {
          boolean _xblockexpression = false;
          {
            final PreparedStatement ps1 = conn.prepareStatement("INSERT INTO Usuarios (NOMBRE, APELLIDO, NOMBRE_USUARIO, EMAIL, FECHA_DE_NAC, VALIDADO,CONTRASENA) VALUES(?,?,?,?,?,?,?)");
            String _nombre = usuario.getNombre();
            ps1.setString(1, _nombre);
            String _apellido = usuario.getApellido();
            ps1.setString(2, _apellido);
            String _nombreDeUsuario = usuario.getNombreDeUsuario();
            ps1.setString(3, _nombreDeUsuario);
            String _email = usuario.getEmail();
            ps1.setString(4, _email);
            Date _fechaDeNac = usuario.getFechaDeNac();
            ps1.setDate(5, _fechaDeNac);
            ps1.setBoolean(6, false);
            String _contrasena = usuario.getContrasena();
            ps1.setString(7, _contrasena);
            ps1.execute();
            final PreparedStatement ps2 = conn.prepareStatement("INSERT INTO Usuarios_Codigo_Validacion (NOMBRE_USUARIO, CODIGO_VALIDACION) VALUES(?,?)");
            String _nombreDeUsuario_1 = usuario.getNombreDeUsuario();
            ps2.setString(1, _nombreDeUsuario_1);
            String _codigoValidacion = usuario.getCodigoValidacion();
            ps2.setString(2, _codigoValidacion);
            _xblockexpression = ps2.execute();
          }
          return Boolean.valueOf(_xblockexpression);
        } catch (Throwable _e) {
          throw Exceptions.sneakyThrow(_e);
        }
      }
    };
    return this.<Boolean>queryDb(_function);
  }
  
  private Connection getConnection() {
    try {
      Class.forName("com.mysql.jdbc.Driver");
      return DriverManager.getConnection("jdbc:mysql://localhost/Pers_TP1?user=root&password=root");
    } catch (Throwable _e) {
      throw Exceptions.sneakyThrow(_e);
    }
  }
}
