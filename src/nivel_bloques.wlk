import wollok.game.*
import fondo.*
import personajes.*
import elementos.*
import nivel_llaves.*
import orientaciones.*
import utilidades.*


object nivelBloques {
	const listaCajas = []
	const puerta1 = new PuertaNivel1(position=game.at(2,6))

	method instrucciones(){
		game.addVisual(new Fondo(image="instrucciones1.png"))
		game.schedule(3000, {
				// ... limpio todo de nuevo
				game.clear()
				// y arranco el siguiente nivel
				self.configurate()
			})
	}

	method configurate() {
		// fondo - es importante que sea el primer visual que se agregue
		game.addVisual(new Fondo(image="bg.png"))
				 
		// otros visuals, p.ej. bloques o llaves
		game.addVisual(puerta1)
		self.crearCajas()
			
		// personaje, es importante que sea el último visual que se agregue
		game.addVisual(personajeNivel1)
		
		// teclado
		// este es para probar, no es necesario dejarlo
		keyboard.t().onPressDo({ self.terminar() })
		keyboard.up().onPressDo{ personajeNivel1.mover(arriba) }
		keyboard.down().onPressDo{ personajeNivel1.mover(abajo) }
		keyboard.left().onPressDo{ personajeNivel1.mover(izquierda) }
		keyboard.right().onPressDo{ personajeNivel1.mover(derecha) }
		keyboard.m().onPressDo{ if(self.cajasEnDepo()){ 
			game.say(personajeNivel1, "las cajas estan en deposito")
			} else { game.say(personajeNivel1, "todavia faltan cajas en el deposito")}
		}
		keyboard.n().onPressDo{if(puerta1.puertaAbierta() and personajeNivel1.enSalida()){ self.terminar() }}
		// en este no hacen falta colisiones
	}
	
	method crearCajas(){ //Falta arreglar que no aparezcan en la misma pos q otros obj
		const caja1 = new Caja()
		game.addVisual(caja1)
		listaCajas.add(caja1)
		//agregar mas instancias
		const caja2 = new Caja()
		game.addVisual(caja2)
		listaCajas.add(caja2)
		const caja3 = new Caja()
		game.addVisual(caja3)
		listaCajas.add(caja3)
		const caja4 = new Caja()
		game.addVisual(caja4)
		listaCajas.add(caja4)
		const caja5 = new Caja()
		game.addVisual(caja5)
		listaCajas.add(caja5)
	}
	
	method cajasEnDepo(){
		return listaCajas.all({c=> c.estaEnDeposito()})
	}
	
	
	method terminar() {
		// game.clear() limpia visuals, teclado, colisiones y acciones
		game.clear()
		// después puedo volver a agregar el fondo, y algún visual para que no quede tan pelado
		game.addVisual(new Fondo(image="bg.png"))
		game.addVisual(personajeNivel1)
		// después de un ratito ...
		game.schedule(2500, {
			game.clear()
			// cambio de fondo
			//game.addVisual(new Fondo(image="finNivel1.png"))
			// después de un ratito ...
			game.schedule(3000, {
				// ... limpio todo de nuevo
				game.clear()
				// y arranco el siguiente nivel
				nivelLlaves.instrucciones()
			})
		})
	}
		
}

