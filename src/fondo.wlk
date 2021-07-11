import wollok.game.*

class Fondo {
	const property position = game.at(0, 0)
	var property image 

	method puedeColisionar() = true 
	method puedeMover() = false
	method esCeldaSorpresa() = false
	method colisionConPj(){}
	method puedePatear() = false
}
