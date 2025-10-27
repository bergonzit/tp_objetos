import tipos.*

class Criatura {
  var property nombre
  var property vida
  const property vidaMax
  var property energia
  const property energiaMax
  var velocidad
  var movimientos //Lista de movimientos [4?]
  var property sprite //Dibujo de la criatura
  var tipo //En teoria los tipos se hacen con otra clase


  method tipo() {
    return tipo
    }

  method sacarVida(cantidad) {
    vida = vida - cantidad
    if (vida < 0) {
      vida = 0
      }
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

  
  method atacar(movimiento, criaturaObjetivo) {
    if (energia >= movimiento.costoEnergia()) {
          movimiento.accion(self, criaturaObjetivo)
        } 
    }


} 

class Laoc inherits Criatura 
(nombre = "Laoc",
 vidaMax = 150, vida = vidaMax,
 energiaMax = 300, energia = energiaMax,
 velocidad = 70,
 movimientos = null,
 sprite = "Laoc256.png",
 tipo = fuego
 ){}

class Seedy inherits Criatura 
(nombre = "Seedy",
 vidaMax = 160, vida = vidaMax,
 energiaMax = 280, energia = energiaMax,
 velocidad = 65,
 movimientos = null,
 sprite = "Seedy256.png",
 tipo = planta
 ){}

class Lacui inherits Criatura 
(nombre = "Lacui",
 vidaMax = 140, vida = vidaMax,
 energiaMax = 320, energia = energiaMax,
 velocidad = 75,
 movimientos = null,
 sprite = "Lacui256.png",
 tipo = agua
 ){}

class Crigmal inherits Criatura 
(nombre = "Crigmal",
 vidaMax = 170, vida = vidaMax,
 energiaMax = 270, energia = energiaMax,
 velocidad = 70,
 movimientos = null,
 sprite = "Crigmal256.png",
 tipo = normal
 ){}

class Argentum inherits Criatura 
(nombre = "Argentum",
 vidaMax = 230, vida = vidaMax,
 energiaMax = 250, energia = energiaMax,
 velocidad = 50,
 movimientos = null,
 sprite = "Argentum256.png",
 tipo = planta
 ){}

 class Soul inherits Criatura
 (nombre = "S O U L",
 vidaMax = 150, vida = vidaMax,
 energiaMax = 300, energia = energiaMax,
 velocidad = 15, //Mantenerlo como el más rapido
 movimientos = null,
 sprite = "Soul256.png",
 tipo = normal
 ){}
