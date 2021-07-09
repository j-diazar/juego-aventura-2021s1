object arriba {
  method posicion(obj) = obj.position().up(1)
}

object abajo {
  method posicion(obj) = obj.position().down(1)
}

object izquierda {
  method posicion(obj) = obj.position().left(1)
}

object derecha {
  method posicion(obj) = obj.position().right(1)
}