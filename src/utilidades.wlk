import wollok.game.*
import elementos.*

object utilidadesParaJuego {
	method posicionArbitraria() {
		return game.at(
			0.randomUpTo(game.width()).truncate(0), 0.randomUpTo(game.height()).truncate(0)
		)
	}
}

class Posiciones{
	method posicionAzar(){
		return game.at(0.randomUpTo(9).truncate(0), 
			0.randomUpTo(9).truncate(0)
		)
	}
	
	method posicionVacia(){
		const objEnPos = game.getObjectsIn( self.posicionAzar() )
		
		return objEnPos.isEmpty()
	}
	
	method posicion(){
		if(self.posicionVacia()){
			return self.posicionAzar()
		}
		else { return self.posicion() }
	}
}

object posicionCajas inherits Posiciones{
	override method posicionAzar(){
		return game.at(1.randomUpTo(9).truncate(0), 
			1.randomUpTo(9).truncate(0)
		)
	}
	
	override method posicion(){
		if(self.posicionVacia() and self.posicionAzar() != puertaBloques.position()){
			return self.posicionAzar()
		}
		else { return self.posicion() }
	}
}

object posicionNivel2 inherits Posiciones{
	override method posicionAzar(){
		return game.at(0.randomUpTo(8).truncate(0), 
			0.randomUpTo(8).truncate(0)
		)
	}
	
	override method posicion(){
		if(self.posicionVacia() and self.posicionAzar() != puertaLlaves.position()){
			return self.posicionAzar()
		}
		else { return self.posicion() }
	}
}