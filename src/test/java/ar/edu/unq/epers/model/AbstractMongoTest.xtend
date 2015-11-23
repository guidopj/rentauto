package ar.edu.unq.epers.model

import org.junit.Before
import org.junit.After
import ar.edu.unq.epers.persistens.ComentariosHome
import ar.edu.unq.epers.services.RedSocialService
import ar.edu.unq.epers.persistens.RedSocialHome
import ar.edu.unq.epers.services.ComentariosService
import org.eclipse.xtend.lib.annotations.Accessors
import ar.edu.unq.epers.services.GraphRunnerService

@Accessors
class AbstractMongoTest {
	
	ComentariosHome comentariosHome
	RedSocialHome redSocialHome
	RedSocialService redSocialService
	ComentariosService comentariosService
	
	def getGraphDb(){
		return GraphRunnerService.graphDb
	}
	
	def void borrarNodosYRelaciones(){
		GraphRunnerService::run[
			var String q = "Match (n)-[r]-() Delete n,r;"
			getGraphDb().execute(q)
		]
	}
	
	@Before
	def void setUp() {
		comentariosHome = new ComentariosHome()
		redSocialHome = new RedSocialHome()
		redSocialService = new RedSocialService(redSocialHome)
		
		comentariosService = new ComentariosService(comentariosHome,redSocialService)
	}
	
	@After
	def void cleanDB(){
		comentariosHome.comentarios.mongoCollection.drop
		borrarNodosYRelaciones
	}
}