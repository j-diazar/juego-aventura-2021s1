import utilidades.*
import personajes.*
import wollok.game.*

class Modificador {
	var property position = posicionNivel2.posicion()
	const property image = ""
	
	method puedePatear() = false
	method puedeColisionar() = true 
	method puedeMover() = false
	method colisionConPj(){
		personajeNivel2.juntarModif(self)
		game.removeVisual(self)
	}
	method efecto(energia){ return energia } //metodo base
}

class Duplicador inherits Modificador{
	override method efecto(energia){
		return energia * 2
	}
	
	override method image(){ return "duplicador.png" }
}

class Reforzador inherits Modificador{
	override method efecto(energia){
		if (personajeNivel2.energia() < 10){ return energia*2 + 20} else { return energia*2}
	}
	
	override method image(){ return "reforzador.png" }
}

class TripleONada inherits Modificador{
	override method efecto(energia){
		if (personajeNivel2.energia().even()){ return energia*3 } else { return energia*0}
	}
	
	override method image(){ return "triple.png" }
}