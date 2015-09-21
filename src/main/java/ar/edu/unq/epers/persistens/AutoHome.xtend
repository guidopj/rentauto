package ar.edu.unq.epers.persistens

import ar.edu.unq.epers.model.Auto
import ar.edu.unq.epers.sesiones.SessionManager

class AutoHome {
	
	def guardarAuto(Auto auto) {
			SessionManager.getSession().save(auto)
	}
	
	def get(int id){
			return SessionManager.getSession().get(typeof(Auto) ,id) as Auto
	}
	
}