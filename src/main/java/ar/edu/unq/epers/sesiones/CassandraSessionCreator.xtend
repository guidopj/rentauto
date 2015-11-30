package ar.edu.unq.epers.sesiones

import com.datastax.driver.core.Cluster
import com.datastax.driver.core.Session
import org.eclipse.xtext.xbase.lib.Functions.Function0
import com.datastax.driver.core.ResultSet
import java.util.Map

class CassandraSessionCreator {
	
	public static Cluster cluster
	public static Session cassandraSession
	
	def static Cluster connect(String nodo){
		return Cluster.builder().addContactPoint(nodo).build()
	}
	
	def static getCacheSession(){
		if(cluster == null){
			cluster = connect("localhost")
			cassandraSession = cluster.connect
		}
		cassandraSession
	}
	
	def static crearKeySpace(String nombreKeyspace){
		executeQuery[|cacheSession.execute("CREATE KEYSPACE "+ nombreKeyspace + " WITH replication "
            + "= {'class':'SimpleStrategy', 'replication_factor':1};")]
        executeQuery[|cacheSession.execute("USE " + nombreKeyspace)]
	}
	
	def static crearStruct(String struct,String nombreKeyspace,String nombreTabla, Map<String,String> campos){
		executeQuery[| 
            var String query = "CREATE "+ struct + " IF NOT EXISTS " + nombreKeyspace +"."+nombreTabla+" ("
            
            for(var int x = 0; x < campos.size -1 ;x++){
            	query = query + " " + campos.keySet.get(x)+ " " + campos.get(campos.keySet.get(x))+ ","
            }
            query = query + " " + campos.keySet.get(campos.size -1)+ " " + campos.get(campos.keySet.get(campos.size -1)) + ");"
            
            System.out.println(query)
			cacheSession.execute(query)
		]
	}
	
	def static void executeQuery(Function0<ResultSet> bloqueQuery) {
		bloqueQuery.apply()
     }
	
	def static eliminarKeyspace(String nombreKeyspace) {
		executeQuery[|
			var String query = "DROP KEYSPACE "+ nombreKeyspace;
			cacheSession.execute(query)
		]
	}
	
	def static eliminarType(String nombreType) {
		executeQuery[|
			var String query = "DROP TYPE IF EXISTS "+ nombreType;
			cacheSession.execute(query)
		]
	}
	
	
}