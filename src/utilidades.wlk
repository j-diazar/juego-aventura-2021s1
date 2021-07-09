import wollok.game.*

object utilidadesParaJuego {
	method posicionArbitraria() {
		return game.at(
			0.randomUpTo(game.width()).truncate(0), 0.randomUpTo(game.height()).truncate(0)
		)
	}
}

object posicionCajas{
	method posicionAzar(){
		return game.at(1.randomUpTo(9).truncate(0), 
			1.randomUpTo(9).truncate(0)
		)
	}
	
	method posicionVacia(){
		const objEnPos = game.getObjectsIn( self.posicionAzar() )
		
		return objEnPos.size() == 0
	}
}

object posicionNivel2{
	method posicionAzar(){
		return game.at(0.randomUpTo(8).truncate(0), 
			0.randomUpTo(8).truncate(0)
		)
	}
}