import personajes.*
import wollok.game.*

object icono{
	var property position = game.at(0,9)
	const property image = "head.png"
	
	method puedePatear() = false
	method puedeColisionar() = false 
	method puedeMover() = false
}

class Corazon{
	var property position
	const property image = "cora.png"
	
	method puedePatear() = false
	method puedeColisionar() = false 
	method puedeMover() = false
}

object cora1 inherits Corazon{
	override method position()= game.at(1,9)
	
	override method image(){
		if (personajeNivel2.energia()<=0){return "coravacio.png"}
		else if(personajeNivel2.energia()<=5){return "corasemivacio.png"}
		else{return "cora.png"}
	}
}

object cora2 inherits Corazon{
	override method position()= game.at(2,9)
	
	override method image(){
		if (personajeNivel2.energia()<=10){return "coravacio.png"}
		else if(personajeNivel2.energia()<=15){return "corasemivacio.png"}
		else{return "cora.png"}
	}
}

object cora3 inherits Corazon{
	override method position()= game.at(3,9)
	
	override method image(){
		if (personajeNivel2.energia()<=20){return "coravacio.png"}
		else if(personajeNivel2.energia()<=25){return "corasemivacio.png"}
		else{return "cora.png"}
	}
}

object cora4 inherits Corazon{
	override method position()= game.at(4,9)
	
	override method image(){
		if (personajeNivel2.energia()<=30){return "coravacio.png"}
		else if(personajeNivel2.energia()<=35){return "corasemivacio.png"}
		else{return "cora.png"}
	}
}


