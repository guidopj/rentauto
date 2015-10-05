package ar.edu.unq.epers.persistens

import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.sesiones.SessionManager
import ar.edu.unq.epers.model.Ubicacion
import java.util.Date
import org.hibernate.Query
import java.util.List

class AutoHome {
	
	def <T> guardar(T element) {
			SessionManager.getSession().save(element)
	}
	
	def <T> borrar(T element) {
			SessionManager.getSession().delete(element)
	}
	
	def obtenerAuto(int id) {
		return SessionManager.getSession().get(typeof(Auto) ,id) as Auto	
	}
	
	def obtenerAutos(Ubicacion ubicacion, Date date) {
		var Query q = SessionManager.getSession().createQuery("from Auto");
		var List<Auto> todos = q.list();
		//q.setInteger("mod", 2008)
		return todos as List<Auto>
	}
	
//	def guardarEmpresa(Empresa empresa) {
//		SessionManager.getSession().save(empresa)
//	}
	
}