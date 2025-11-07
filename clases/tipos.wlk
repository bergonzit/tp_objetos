class Tipo {
  const property nombre
  const property imagen
  const ventajas = []
  const desventajas = []
  
  method obtenerMult(otroTipo) {
    if (ventajas.contains(otroTipo)) {
      return 2
    } else if (desventajas.contains(otroTipo)) {
      return 0.5
    } else {
      return 1
    }
  }

  method image() = imagen

}

const normal = new Tipo(
  nombre = "Normal",
  imagen = "Normal.png",
  ventajas = [],
  desventajas = []
)

const fuego = new Tipo(
  nombre = "Fuego",
  imagen = "Fuego.png",
  ventajas = [planta],
  desventajas = [agua]
)

const agua = new Tipo(
  nombre = "Agua",
  imagen = "Agua.png",
  ventajas = [fuego],
  desventajas = [planta]
)

const planta = new Tipo(
  nombre = "Planta",
  imagen = "Planta.png",
  ventajas = [agua],
  desventajas = [fuego]
)

//Solo para movimiento de tipo Curacion
const curacion = new Tipo(
  nombre = "Curacion",
  imagen = "",
  ventajas = [],
  desventajas = []
)