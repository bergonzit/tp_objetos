class Criatura {
  var nombre
  var vida
  var vidaMax
  var energia
  var energiaMax
  var velocidad
  var movimientos //Lista de movimientos [4?]
  var sprite //Dibujo de la criatura
  var tipo //En teoria los tipos se hacen con otra clase

} 

//Aca armo un ejemplo de una criatura con herencia

class Koi inherits Criatura 
(nombre = "Koi",
 vidaMax = 100, vida = vidaMax,
 energiaMax = 100, energia = energiaMax,
 velocidad = 50,
 movimientos = null,
 sprite = null,
 tipo = null
 ){
    
}

object run {
  
}