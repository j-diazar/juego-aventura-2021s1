import wollok.game.*
import fondo.*
import personajes.*
import elementos.*
import orientaciones.*
import barraEnergia.*
import modificadores.*

object nivelLlaves {
	
	method instrucciones(){
		game.addVisual(new Fondo(image="instrucciones2.png"))
		game.schedule(3000, {
			game.clear()
			// cambio de fondo
			game.addVisual(new Fondo(image="instruccionesMODIF.png"))
			// después de un ratito ...
			game.schedule(2500, {
				// fin del juego
				game.clear()
				self.configurate()
			})
		})
	}

	method configurate() {
		// fondo - es importante que sea el primer visual que se agregue
		game.addVisual(new Fondo(image="bg2.png"))
				 
		// otros visuals, p.ej. bloques o llaves
		game.addVisual(icono)
		game.addVisual(cora1)
		game.addVisual(cora2)
		game.addVisual(cora3)
		game.addVisual(cora4)
		game.addVisual(puertaLlaves)
		game.addVisual(new Duplicador)
		game.addVisual(new Reforzador)
		game.addVisual(new TripleONada)
		game.addVisual(new Llave)
		game.addVisual(new Llave)
		game.addVisual(new Llave)
		game.addVisual(new Pollo)
			
		// personaje, es importante que sea el último visual que se agregue
		game.addVisual(personajeNivel2)
		
		// teclado
		// este es para probar, no es necesario dejarlo
		keyboard.g().onPressDo({ self.ganar() })
		keyboard.up().onPressDo{ personajeNivel2.mover(arriba) }
		keyboard.down().onPressDo{ personajeNivel2.mover(abajo) }
		keyboard.left().onPressDo{ personajeNivel2.mover(izquierda) }
		keyboard.right().onPressDo{ personajeNivel2.mover(derecha) }
		keyboard.m().onPressDo{ game.say(personajeNivel2, "tengo " + personajeNivel2.llaves() + " llaves." )}
		keyboard.n().onPressDo{ game.say(personajeNivel2, "tengo " + personajeNivel2.energia() + " energia.")}
		keyboard.b().onPressDo{ 
			if(puertaLlaves.puertaAbierta() and personajeNivel2.enSalida()){ self.ganar() }
		}

		// colisiones, acá sí hacen falta
		game.onCollideDo(personajeNivel2, { obj => personajeNivel2.colisionCon(obj)})
		
	}
	
	method ganar(){
			game.clear()
			game.addVisual(new Fondo(image="ganar.png"))
			game.schedule(2500, {
				game.clear()
				game.stop()
				})
	}
	
	method perder(){
			game.clear()
			game.addVisual(new Fondo(image="perder.png"))
			game.schedule(2500, {
				game.clear()
				game.stop()
				})
			}
	}
	
	/*method ganar() {
		// es muy parecido al terminar() de nivelBloques
		// el perder() también va a ser parecido
		
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
		// después puedo volver a agregar el fondo, y algún visual para que no quede tan pelado
		game.addVisual(new Fondo(image="bg2.png"))
		// después de un ratito ...
		game.schedule(2500, {
			game.clear()
			// cambio de fondo
			game.addVisual(new Fondo(image="ganamos.png"))
			// después de un ratito ...
			game.schedule(3000, {
				// fin del juego
				game.stop()
			})
		})
	}
	*/
	
}
