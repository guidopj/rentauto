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

class RedSocialTest {
	
	RedSocialHome redSocialHome
	RedSocialService redSocialService
	Usuario usuario1
	Usuario usuario2
	Usuario usuario3
	
	@Before
	def void setUp(){
		redSocialHome = new RedSocialHome()
		redSocialService = new RedSocialService(redSocialHome)
		usuario1 = new Usuario("nombreUsuairo1", "apellidoUsuario1", "usuario1", "usuario1@yahoo.com")
		usuario2 = new Usuario("nombreUsuairo2", "apellidoUsuario2", "usuario2", "usuario2@yahoo.com")
		usuario3 = new Usuario("nombreUsuairo3", "apellidoUsuario3", "usuario3", "usuario3@yahoo.com")
		redSocialService.anadirUsuario(usuario1)
		redSocialService.anadirUsuario(usuario2)
		
	}
	
	def getGraphDb(){
		return GraphRunnerService.graphDb
	}
	
	//Como usuario quiero poder agregar a mis amigos que ya son miembro del sitio.
	@Test
	def void agregarAmigo_TEST(){
		redSocialService.agregarRelacionEntre(usuario1,usuario2,Relacion.AMISTAD)
		var Result result = redSocialService.obtenerRelacionesDe(usuario1,Relacion.AMISTAD)
		Assert.assertTrue(result.resultAsString.contains("usuario2"))
		Assert.assertFalse(result.resultAsString.contains("usuario1"))
	}
	
	@Test(expected=NoExisteUsuarioEnRedSocialException)
	def void agregarAmigoNoEsParteDeRedSocial_TEST(){
		redSocialService.agregarRelacionEntre(usuario2,usuario3,Relacion.AMISTAD)
	}
	
	//Como usuario quiero poder consultar a mis amigos
	
	@Test
	def void consultarAmigos_TEST(){
		redSocialService.agregarRelacionEntre(usuario1,usuario2,Relacion.AMISTAD)
		redSocialService.anadirUsuario(usuario3)
		redSocialService.agregarRelacionEntre(usuario1,usuario3,Relacion.AMISTAD)
		
		val Result result = redSocialService.obtenerRelacionesDe(usuario1,Relacion.AMISTAD)
		
		Assert.assertTrue(result.resultAsString.contains("usuario2"))
		Assert.assertTrue(result.resultAsString.contains("usuario3"))
	}
	
	@After
	def void borrarNodosYRelaciones(){
		GraphRunnerService::run[
			var String q = "Match (n)-[r]-() Delete n,r;"
			getGraphDb().execute(q)
		]
	}
}