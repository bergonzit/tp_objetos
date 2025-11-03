import tipos.*
import movimientos.*
class Criatura {
  var property nombre
  var property vida
  const property vidaMax
  var property energia
  const property energiaMax
  var property velocidad
  var property ultimoMovimiento = null
  var property movimientos //Lista de movimientos [4?]
  var property sprite //Dibujo de la criatura
  var property posicion = game.origin()
  var property offsetY
  var property tipo 
  var property esDeJugador = true

  method sacarVida(cantidad) {
    vida = vida - cantidad
    if (vida < 0) {
      vida = 0
      }
    }

  method tieneEnergia(index){
    return energia >= movimientos.get(index).costo()
  }

  method restarEnergia(cantidad) {
    energia = energia - cantidad
    if (energia < 0) {
      energia = 0
    }
  }

  method estaViva() {
    return vida > 0
  }

  method porcentajeEnergiaRestante(){
    return  (100 * energia / energiaMax).round()
  }

  method porcentajeVidaRestante(){
    return  (100 * vida / vidaMax).round()
  }
  
  method atacar(movimiento, criaturaObjetivo) {
    ultimoMovimiento = movimiento.nombre()
    return movimiento.accion(self,criaturaObjetivo)
  }

  method movimientosDisponibles(){
    return movimientos.filter({movimiento => movimiento.costo() <= energia})
  }

  method image() = sprite.get( if (esDeJugador) 1 else 0)
  method position() = posicion

} 

class Laoc inherits Criatura 
(nombre = "Laoc",
 vidaMax = 150, vida = vidaMax,
 energiaMax = 300, energia = energiaMax,
 velocidad = 70,
 movimientos = [placaje,calentar,placaje,placaje],
 sprite = ["Laoc256.png","Laoc_B256.png"],
 offsetY = 4,
 tipo = fuego
 ){}

class Lacui inherits Criatura 
(nombre = "Lacui",
 vidaMax = 140, vida = vidaMax,
 energiaMax = 320, energia = energiaMax,
 velocidad = 75,
 movimientos = [placaje,placaje,placaje,placaje],
 sprite = ["Lacui256.png","Lacui_B256.png"],
 offsetY = 8,
 tipo = agua
 ){}

class Seedy inherits Criatura 
(nombre = "Seedy",
 vidaMax = 160, vida = vidaMax,
 energiaMax = 280, energia = energiaMax,
 velocidad = 65,
 movimientos = [placaje,placaje,placaje,placaje],
 sprite = ["Seedy256.png","Seedy_B256.png"],
 offsetY = 10,
 tipo = planta
 ){}

class Crigmal inherits Criatura 
(nombre = "Crigmal",
 vidaMax = 170, vida = vidaMax,
 energiaMax = 270, energia = energiaMax,
 velocidad = 70,
 movimientos = [placaje,placaje,placaje,placaje],
 sprite = ["Crigmal256.png","Crigmal_B256.png"],
 offsetY = 4,
 tipo = normal
 ){}

class Emblem inherits Criatura 
(nombre = "Emblem",
 vidaMax = 140, vida = vidaMax,
 energiaMax = 330, energia = energiaMax,
 velocidad = 60,
 movimientos = [placaje,calentar,placaje,placaje],
 sprite = ["Emblem256.png","Emblem_B256.png"],
 offsetY = 5,
 tipo = fuego
 ){}

class Bloo inherits Criatura 
(nombre = "Bloo",
 vidaMax = 160, vida = vidaMax,
 energiaMax = 280, energia = energiaMax,
 velocidad = 60,
 movimientos = [placaje,placaje,placaje,placaje],
 sprite = ["Bloo256.png","Bloo_B256.png"],
 offsetY = 6,
 tipo = agua
 ){}

class Argentum inherits Criatura 
(nombre = "Argentum",
 vidaMax = 230, vida = vidaMax,
 energiaMax = 250, energia = energiaMax,
 velocidad = 50,
 movimientos = [placaje,placaje,placaje,placaje],
 sprite = ["Argentum256.png","Argentum_B256.png"],
 offsetY = 5,
 tipo = planta
 ){}


class Soul inherits Criatura
 (nombre = "Soul",
 vidaMax = 150, vida = vidaMax,
 energiaMax = 300, energia = energiaMax,
 velocidad = 100,
 movimientos = [placaje,placaje,placaje,placaje],
 sprite = ["Soul256.png","Soul_B256.png"],
 offsetY = 7,
 tipo = normal
 ){}

class Leefo inherits Criatura 
(nombre = "Leefo",
 vidaMax = 150, vida = vidaMax,
 energiaMax = 300, energia = energiaMax,
 velocidad = 65,
 movimientos = [placaje,placaje,placaje,placaje],
 sprite = ["Leefo256.png","Leefo_B256.png"],
 offsetY = 7,
 tipo = planta
 ){}

class Ouroboros inherits Criatura
 (nombre = "Ouroboros",
 vidaMax = 140, vida = vidaMax,
 energiaMax = 350, energia = energiaMax,
 velocidad = 70,
 movimientos = [placaje,placaje,placaje,placaje],
 sprite = ["Ouroboros256.png","Ouroboros_B256.png"],
 offsetY = 4,
 tipo = normal
 ){}
