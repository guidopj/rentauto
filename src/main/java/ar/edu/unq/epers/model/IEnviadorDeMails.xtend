package ar.edu.unq.epers.model

interface IEnviadorDeMails {
	def void enviarMail(Mail mail);
}