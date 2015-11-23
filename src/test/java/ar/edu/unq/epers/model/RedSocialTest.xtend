package ar.edu.unq.epers.model

import org.junit.Before
import ar.edu.unq.epers.persistens.RedSocialHome
import ar.edu.unq.epers.services.RedSocialService
import org.junit.Test
import ar.edu.unq.epers.services.GraphRunnerService
import org.neo4j.graphdb.Result
import org.junit.After
import org.junit.Assert
import ar.edu.unq.epers.excepciones.NoExisteUsuarioEnRedSocialException
import java.util.List
import java.util.ArrayList
import ar.edu.unq.epers.excepciones.NoSonAmigosException
import java.util.Set
import java.util.HashSet

class RedSocialTest {
	
	RedSocialHome redSocialHome
	RedSocialService redSocialService
	Usuario usuario1
	Usuario usuario2
	Usuario usuario3
	Usuario usuario4
	
	@Before
	def void setUp(){
		redSocialHome = new RedSocialHome()
		redSocialService = new RedSocialService(redSocialHome)
		usuario1 = new Usuario("nombre1", "apellidoUsuario1", "nombreUsuairo1", "usuario1@yahoo.com")
		usuario2 = new Usuario("nombre2", "apellidoUsuario2", "nombreUsuairo2", "usuario2@yahoo.com")
		usuario3 = new Usuario("nombre3", "apellidoUsuario3", "nombreUsuairo3", "usuario3@yahoo.com")
		usuario4 = new Usuario("nombre4", "apellidoUsuario4", "nombreUsuairo4", "usuario4@yahoo.com")
		redSocialService.anadirUsuario(usuario1)
		redSocialService.anadirUsuario(usuario2)
		redSocialService.anadirUsuario(usuario4)
		
	}
	
	def getGraphDb(){
		return GraphRunnerService.graphDb
	}
	
	//Como usuario quiero poder agregar a mis amigos que ya son miembro del sitio.
	@Test
	def void agregarAmigo_TEST(){
		var List<String> usuarios = new ArrayList<String>
		redSocialService.agregarRelacionEntre(usuario1,usuario2,Relacion.AMISTAD)
		usuarios = redSocialService.obtenerRelacionesDe(usuario1,Relacion.AMISTAD)
		
		Assert.assertTrue(usuarios.contains("nombreUsuairo2"))
		Assert.assertEquals(1,usuarios.length)
	}
	
	@Test(expected=NoExisteUsuarioEnRedSocialException)
	def void agregarAmigoNoEsParteDeRedSocial_TEST(){
		redSocialService.agregarRelacionEntre(usuario2,usuario3,Relacion.AMISTAD)
	}
	
	//Como usuario quiero poder consultar a mis amigos
	
	@Test
	def void consultarAmigos_TEST(){
		var List<String> usuarios = new ArrayList<String>
		redSocialService.agregarRelacionEntre(usuario1,usuario2,Relacion.AMISTAD)
		redSocialService.anadirUsuario(usuario3)
		redSocialService.agregarRelacionEntre(usuario1,usuario3,Relacion.AMISTAD)
		
		usuarios = redSocialService.obtenerRelacionesDe(usuario1,Relacion.AMISTAD)
		
		Assert.assertTrue(usuarios.contains("nombreUsuairo2"))
		Assert.assertTrue(usuarios.contains("nombreUsuairo3"))
		Assert.assertFalse(usuarios.contains("nombreUsuairo4"))
	}
	
	//Como usuario quiero poder mandar mensajes a mis amigos.
	
	
	@Test(expected=NoSonAmigosException)
	def void envioMensajeSinSerAmigo_TEST(){
		var Mensaje men = new Mensaje(usuario1.nombreDeUsuario,usuario2.nombreDeUsuario,"un asunto para un mensaje","un contenido para un mensaje")
		redSocialService.mandarMensajeA(usuario1,usuario2,men)
	}
	
	@Test
	def void envioMensajeSiendoAmigo_TEST(){
		redSocialService.agregarRelacionEntre(usuario1,usuario2,Relacion.AMISTAD)
		var Mensaje men = new Mensaje(usuario1.nombreDeUsuario,usuario2.nombreDeUsuario,"un asunto para un mensaje","un contenido para un mensaje")
		redSocialService.mandarMensajeA(usuario1,usuario2,men)
		
		var List<Mensaje> mensajes = redSocialService.obtenerMensajesDe(usuario2,Relacion.RECEPTOR)
		//los mensajes de usuario2
		Assert.assertEquals("un contenido para un mensaje",mensajes.get(0).contenido)
		Assert.assertEquals(1,mensajes.length)
	}
	
	/**
	 * Como usuario quiero poder saber todas las personas 
	 * con las que estoy conectado, o sea mis amigos 
	 * y los amigos de mis amigos recursivamente
	 */
	 
	 @Test
	 def void amigosConectados_TEST(){
	 	redSocialService.anadirUsuario(usuario3)
	 	
	 	redSocialService.agregarRelacionEntre(usuario1,usuario2,Relacion.AMISTAD)
	 	redSocialService.agregarRelacionEntre(usuario2,usuario3,Relacion.AMISTAD)
	 	redSocialService.agregarRelacionEntre(usuario3,usuario4,Relacion.AMISTAD)
	 	
	 	var Set <String> usr = new HashSet<String>
		
	 	usr = redSocialService.conectadosDe(usuario1)
	 
		Assert.assertTrue(usr.contains(usuario2.nombreDeUsuario))
		Assert.assertTrue(usr.contains(usuario3.nombreDeUsuario))
		Assert.assertTrue(usr.contains(usuario4.nombreDeUsuario))
	 }
	
	@After
	def void borrarNodosYRelaciones(){
		GraphRunnerService::run[
			var String q = "Match (n)-[r]-() Delete n,r;"
			getGraphDb().execute(q)
		]
	}
}