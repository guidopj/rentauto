package ar.edu.unq.epers.model

import org.junit.Before
import java.sql.Date
import org.junit.Assert
import org.junit.Test

class Usuario_Test {
	
	Date fechaNac;
	Usuario usuario1;
	
	@Before
	def void setUp(){
		fechaNac = new Date(1990,01,01);
		usuario1 = new Usuario("usu1Nombre","usu1Apellido","usu1Nombre_Usaurio","usu1_email",fechaNac,"");
	}
	
	@Test
	def void validarUSU1(){
		usuario1.validarme();
		Assert.assertEquals(true,usuario1.validado);
	}
}