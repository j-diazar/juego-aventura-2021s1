import wollok.game.*
import orientaciones.*
import elementos.*
import nivel_llaves.*
import modificadores.*

//PERSONAJE BASE
class PersonajeSimple{ 
	var property position = game.origin()
	const property image = "player.png"	
	
	//MOVIMIENTO
	method mover(unaOrientacion) { 
		if(self.puedoMoverAl(unaOrientacion) and self.posNoEsBorde(unaOrientacion)) {
			self.position(unaOrientacion.posicion(self))
		} 
		else {}
	}
	
	method puedoMoverAl( unaOrientacion ) {
		return game.getObjectsIn( unaOrientacion.posicion(self) ).all { unObj => unObj.puedeColisionar()}
	}
	
	method posNoEsBorde(unaOrientacion){
		return unaOrientacion.posicion(self).x().between(0,9) and
		unaOrientacion.posicion(self).y().between(0,9)
	}
	
	method enSalida(){
		return self.position().x() == 2 and self.position().y() == 5
	}
}


//PERSONAJE NIVEL 1
object personajeNivel1 inherits PersonajeSimple {
	
	//MOVIMIENTO
	override method mover(unaOrientacion) { 
		if(self.puedoMoverAl(unaOrientacion) and self.posNoEsBorde(unaOrientacion)) {
			self.position(unaOrientacion.posicion(self))
		} else if (self.puedoEmpujarAl(unaOrientacion)) {
			self.empujar(unaOrientacion)
			self.position(unaOrientacion.posicion(self))
		}
		else {}
	}
	
	//comportamiento con cajas
	method empujar(unaOrientacion) {
		game.getObjectsIn(unaOrientacion.posicion(self)).forEach { caja => caja.mover(unaOrientacion)}
	}
		
	method puedoEmpujarAl(unaOrientacion){
		const objEnPos = game.getObjectsIn( unaOrientacion.posicion(self) )
		
		return objEnPos.size() >= 1 and objEnPos.all { unObj => unObj.puedeMover()}
	}

}

//PERSONAJE NIVEL 2 
object personajeNivel2 inherits PersonajeSimple{
	var property energia = 40
	var property llaves = 0
	var property modificador = new Modificador() //inicializacion de modificador base sin efecto
	
	override method posNoEsBorde(unaOrientacion){
		return unaOrientacion.posicion(self).x().between(0,9) and
		unaOrientacion.posicion(self).y().between(0,8)
	}
	
	method colisionCon(obj){
		if (obj.puedeColisionar()){ obj.colisionConPj()}
	}
	
	//comportamiento con llave
	method agarrarLlave(){
		llaves = llaves +1
	}
	
	override method mover(unaOrientacion) { 
		if(self.puedoMoverAl(unaOrientacion) and self.posNoEsBorde(unaOrientacion) and energia >= 1) {
			self.position(unaOrientacion.posicion(self))
			energia = energia-1
		}
		else if(self.puedePatearCofre(unaOrientacion)){ //patea moviendose en vez de con tecla
			self.patearCofre(unaOrientacion)
			energia = energia-6
		}
		else if(energia == 0) {
			nivelLlaves.perder()
		}
		else {}
	}
	
	//comportamiento con pollos
	method comerPollo(pollo){
		energia = energia + pollo.energiaQueAporta()
		if (energia>=40){
			energia = energia.min(40)
		}
	}
	method juntarModif(modif) {
		modificador = modif
	}
	
	//comportamiento con cofres
	method puedePatearCofre(unaOrientacion){
		const objEnPos = game.getObjectsIn( unaOrientacion.posicion(self) )
		
		return objEnPos.size() >= 1 and objEnPos.all { unObj => unObj.puedePatear()}
	}
	
	method patearCofre(unaOrientacion){
		game.getObjectsIn(unaOrientacion.posicion(self)).forEach { cofre => cofre.abrir()} 
	}
	
}
