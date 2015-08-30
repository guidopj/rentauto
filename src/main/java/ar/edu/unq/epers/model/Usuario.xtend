package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors
import java.sql.Date

@Accessors
class Usuario {
	String nombre;
	String apellido;
	String nombre_de_usuario;
	String email;
	Date fecha_de_nac;
}