/*class Tipo {
  var nombre
  var multFuego
  var multAgua
  var multPlanta
  
  method obtenerMult(valor) {
    return if (valor == "Fuego") multFuego else if (valor == "Agua") multAgua else if (valor == "Planta") multPlanta else 1
  }

  method getNombre(){
    return nombre
  }
}

object fuego inherits Tipo(nombre = "Fuego", multFuego = 1, multAgua = 0.5, multPlanta = 2) {}
object agua inherits Tipo(nombre = "Agua", multFuego = 2, multAgua = 1, multPlanta = 0.5) {}
object planta inherits Tipo(nombre = "Planta", multFuego = 0.5, multAgua = 2, multPlanta = 1) {}
object normal inherits Tipo(nombre = "Normal", multFuego = 1, multAgua = 1, multPlanta = 1) {}*/

class Tipo {
  var nombre
  var ventajas = []
  var desventajas = []
  
  method obtenerMult(otroTipo) {
    if (ventajas.contains(otroTipo)) {
      return 2
    } else if (desventajas.contains(otroTipo)) {
      return 0.5
    } else {
      return 1
    }
  }

  method getNombre(){
    return nombre
  }
}

const normal = new Tipo(
  nombre = "Normal",
  ventajas = [],
  desventajas = []
)

const fuego = new Tipo(
  nombre = "Fuego",
  ventajas = [planta],
  desventajas = [agua]
)

const agua = new Tipo(
  nombre = "Agua",
  ventajas = [fuego],
  desventajas = [planta]
)

const planta = new Tipo(
  nombre = "Planta",
  ventajas = [agua],
  desventajas = [fuego]
)