import tipos.*

class Criatura {
  var nombre
  var property vida
  var vidaMax
  var property energia
  var energiaMax
  var velocidad
  var movimientos //Lista de movimientos [4?]
  var sprite //Dibujo de la criatura
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
 sprite = "Laoc128.png",
 tipo = fuego
 ){}

class Seedy inherits Criatura 
(nombre = "Seedy",
 vidaMax = 160, vida = vidaMax,
 energiaMax = 280, energia = energiaMax,
 velocidad = 65,
 movimientos = null,
 sprite = "Seedy128.png",
 tipo = planta
 ){}

 class Lacui inherits Criatura 
(nombre = "Lacui",
 vidaMax = 140, vida = vidaMax,
 energiaMax = 320, energia = energiaMax,
 velocidad = 75,
 movimientos = null,
 sprite = "Lacui128.png",
 tipo = agua
 ){}
