class Tipo {
  var nombre
  var multFuego
  var multAgua
  var multPlanta
  
  method obtenerMult(valor) {
    return if (valor == "Fuego") multFuego else if (valor == "Agua") multAgua else if (valor == "Planta") multPlanta else 1
  }
}

object fuego inherits Tipo(nombre = "Fuego", multFuego = 1, multAgua = 0.5, multPlanta = 2) {}
object agua inherits Tipo(nombre = "Agua", multFuego = 2, multAgua = 1, multPlanta = 0.5) {}
object planta inherits Tipo(nombre = "Planta", multFuego = 0.5, multAgua = 2, multPlanta = 1) {}
object normal inherits Tipo(nombre = "Normal", multFuego = 1, multAgua = 1, multPlanta = 1) {}