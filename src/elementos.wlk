import wollok.game.*
import utilidades.*
import orientaciones.*
import nivel_bloques.*
import personajes.*
import modificadores.*

//elementos base
class Puerta{
	var property position
	const property image = "puertaCerrada.png" 	
	
	method puedeColisionar() = false 
	method puedeMover() = false
	
	method image(){
		if (self.puertaAbierta()){ return "puertaAbierta.png"} else {return "puertaCerrada.png"}
	}
	
	method puertaAbierta(){return true}
}

//ELEMENTOS NIVEL 1
class PuertaNivel1 inherits Puerta {
	
	override method puertaAbierta(){
		return nivelBloques.cajasEnDepo()
	}
}

class Caja{
	var property position = posicionCajas.posicionAzar()
	const property image = "caja.png"
	
	method puedeColisionar() = false 
	
	method puedeMover() = true
	
	method mover(unaOrientacion) {
		if(self.puedoMoverAl(unaOrientacion) and self.posNoEsBorde(unaOrientacion)) {
			self.position(unaOrientacion.posicion(self))
		} else {}
	}
	
	method puedoMoverAl( unaOrientacion ) {
		return game.getObjectsIn( unaOrientacion.posicion(self) ).all { unObj => unObj.puedeColisionar()}
	}
	
	method posNoEsBorde(unaOrientacion){
		return unaOrientacion.posicion(self).x().between(0,9) and
		unaOrientacion.posicion(self).y().between(0,9)
	}
	
	method estaEnDeposito(){
		return self.position().x().between(5,7) and 
		self.position().y().between(6,7)
	}
	
	method image(){
		if (self.estaEnDeposito()){ return "cajaDepo.png"} else {return "caja.png"}
	}
}

//ELEMENTOS NIVEL 2

class Llave{
	var property position = posicionNivel2.posicionAzar()
	const property image = "llave.png"
	
	method puedeColisionar() = true 
	method puedeMover() = false
	method colisionConPj(){
		personajeNivel2.agarrarLlave()
		game.removeVisual(self)
	}
	
}

object puertaLlaves inherits Puerta{
	override method position() = game.at(2, 6)
	
	
	override method puedeColisionar(){ return !(self.puertaAbierta())}
	
	override method image(){
		if (self.puertaAbierta()){ return "puertaAbierta.png"} else {return "vacio.png"}
	}
	
	override method puertaAbierta(){ return personajeNivel2.llaves() == 3}
	
	method colisionConPj(){}
}

class Pollo{
	var property position = posicionNivel2.posicionAzar()
	const property image = "pollo.png"
	var property energiaQueAporta = 5.randomUpTo(40).truncate(0)
	
	method puedeColisionar() = true 
	method puedeMover() = false
	method colisionConPj(){
		self.aplicarModif()
		personajeNivel2.comerPollo(self)
		game.removeVisual(self)
	}
	
	method aplicarModif() {
		energiaQueAporta = personajeNivel2.modificador().efecto(energiaQueAporta)
	}
}