package ar.edu.unq.epers.mailing

import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Mail implements IEnviadorDeMails{
	
	String body;
	String subject;
	String to;
	String from;
	
	new(String body, String subject, String to, String from){
		this.body = body;
		this.subject = subject;
		this.to = to;
		this.from = from;
	}
	
	new(){
		
	}
	
	override enviarMail(Mail mail) {}
	
}