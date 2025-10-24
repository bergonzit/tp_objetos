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
  var property tipo //En teoria los tipos se hacen con otra clase

  method tomarValorMayorEntreCeroYoOtro(valorAComparar) = valorAComparar.max(0)

  method sacarVida(cantidad) {
    vida = self.tomarValorMayorEntreCeroYoOtro(vida - cantidad)
    }

  method restarEnergia(cantidad) {
      energia = self.tomarValorMayorEntreCeroYoOtro(energia - cantidad)
    }

  method estaViva() = vida > 0


  
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
