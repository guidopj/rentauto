package ar.edu.unq.epers.model

import org.junit.Test
import org.junit.Assert
import org.mongojack.DBQuery
import scala.Array
import java.util.List

class ComentariosService_Test extends AbstractMongoTest{
	
	
	def coleccionComentarios(){
		comentariosHome.comentarios.getMongoCollection()
	}
	
	@Test
	def void anadirComentario() {
		var Usuario usuario1 = new Usuario("nombreUsuairo1", "apellidoUsuario1", "usuario1", "usuario1@yahoo.com")
		//var Auto auto1 = new Auto("Fiat","Uno",1999,"ABC123",new Turismo(),new Double(1000),ubicacionRetiro)
		
		comentariosService.hacerComentario("ABC123",Visibilidad.PRIVADO,Calificacion.BUENO,"muy bueno",usuario1)
		
		val query = DBQuery.in("patenteAuto", "ABC123")
		val comentariosDeAuto = coleccionComentarios.find(query).toArray
		
		Assert.assertEquals("ABC123",comentariosDeAuto.get(0).patenteAuto)
		Assert.assertEquals(1,comentariosDeAuto.size)
	}
	
	@Test
	def void obtenerPerfilPublicoDeUsuario(){
		var Usuario usuario1 = new Usuario("nombreUsuairo1", "apellidoUsuario1", "usuario1", "usuario1@yahoo.com")
		var Usuario usuario2 = new Usuario("nombreUsuairo2", "apellidoUsuario2", "usuario2", "usuario2@yahoo.com")
		
		redSocialService.anadirUsuario(usuario1)
		redSocialService.anadirUsuario(usuario2)

		
		comentariosService.hacerComentario("ABC123",Visibilidad.PRIVADO,Calificacion.BUENO,"muy bueno",usuario2)
		comentariosService.hacerComentario("DEF234",Visibilidad.PUBLICO,Calificacion.BUENO,"muy bueno",usuario2)
		comentariosService.hacerComentario("FGH678",Visibilidad.AMIGO,Calificacion.BUENO,"muy bueno",usuario2)
		
		var List<Comentario> comentarios = comentariosService.verPerfilDe(usuario1,usuario2)
		Assert.assertEquals("DEF234",comentarios.get(0).patenteAuto)
	}
	
	@Test
	def void obtenerPerfilAmigoDeUsuario(){
		var Usuario usuario1 = new Usuario("nombreUsuairo1", "apellidoUsuario1", "usuario1", "usuario1@yahoo.com")
		var Usuario usuario2 = new Usuario("nombreUsuairo2", "apellidoUsuario2", "usuario2", "usuario2@yahoo.com")
	
		redSocialService.anadirUsuario(usuario1)
		redSocialService.anadirUsuario(usuario2)
		
		redSocialService.agregarRelacionEntre(usuario1,usuario2,Relacion.AMISTAD)
		
		comentariosService.hacerComentario("ABC123",Visibilidad.PRIVADO,Calificacion.BUENO,"muy bueno",usuario2)
		comentariosService.hacerComentario("DEF234",Visibilidad.PUBLICO,Calificacion.BUENO,"muy bueno",usuario2)
		comentariosService.hacerComentario("FGH678",Visibilidad.AMIGO,Calificacion.BUENO,"muy bueno",usuario2)
		
		var List<Comentario> comentarios = comentariosService.verPerfilDe(usuario1,usuario2)
		
		Assert.assertEquals("DEF234",comentarios.get(0).patenteAuto)
		Assert.assertEquals("FGH678",comentarios.get(1).patenteAuto)
	}
	
	@Test
	def void obtenerPerfilPRIVADODeUsuario(){
		var Usuario usuario1 = new Usuario("nombreUsuairo1", "apellidoUsuario1", "usuario1", "usuario1@yahoo.com")
		var Usuario usuario2 = new Usuario("nombreUsuairo2", "apellidoUsuario2", "usuario1", "usuario2@yahoo.com")
	
		redSocialService.anadirUsuario(usuario1)
		redSocialService.anadirUsuario(usuario2)
		
		
		comentariosService.hacerComentario("ABC123",Visibilidad.PRIVADO,Calificacion.BUENO,"muy bueno",usuario2)
		comentariosService.hacerComentario("DEF234",Visibilidad.PUBLICO,Calificacion.MALO,"muy MALO",usuario2)
		comentariosService.hacerComentario("FGH678",Visibilidad.AMIGO,Calificacion.EXCELENTE,"excelente",usuario2)
		
		var List<Comentario> comentarios = comentariosService.verPerfilDe(usuario1,usuario2)
		
		Assert.assertEquals("ABC123",comentarios.get(0).patenteAuto)
		Assert.assertEquals("DEF234",comentarios.get(1).patenteAuto)
		Assert.assertEquals("FGH678",comentarios.get(2).patenteAuto)
	}
	
}