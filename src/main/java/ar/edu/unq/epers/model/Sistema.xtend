package ar.edu.unq.epers.model

import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import java.util.ArrayList

@Accessors 
class Sistema {
	
	List listaUsuarios;
	Home_Sistema homeSistema;
	
	new(){
		this.listaUsuarios = new ArrayList<Usuario>();
	}
	
	def registrar(Usuario usuario){
		this.getHomeSistema().anadir(usuario);
	}
}