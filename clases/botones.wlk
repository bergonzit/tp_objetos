import gestorPantallas.gestorPantallas
import pantallaMenu.pantallaMenu
import pantallaSeleccionCriatura.pantallaSeleccionCriatura
import clases.jugador.jugador
import clases.criaturas.*
/*class Boton{
    var sprite = ["boton.png","boton_hover.png"]
    var property posicion = game.center()
    method position() = posicion 
    var hover = false
    method image() = sprite.get(if (hover) 1 else 0)
    method press() 
    //method press()
    method cambiarHover(){
        hover = !hover
    }


}

object botonJugar inherits Boton(){
    override method press(){
        gestorPantallas.cambiarSeleccionCriatura()
    }
}

//Todavia no se para que vamos a usarlo pero lo dejo x si acaso
object botonAux inherits Boton(){
    override method press(){
        game.say(self, "Soy un Boton")
    }
}*/

/*class Boton{
    var sprite = ["boton.png","boton_hover.png"]
    var property posicion = game.center()
    var pantalla
    method position() = posicion 
    var hover = false
    method image() = sprite.get(if (hover) 1 else 0)
    method press(){
        gestorPantallas.cambiarPantalla(pantalla)
    } 
    method cambiarHover(){
        hover = !hover
    }

}

const botonJugar = new Boton(pantalla = pantallaSeleccionCriatura)
const botonAux = new Boton(pantalla = pantallaMenu)*/


class Boton{
    var sprite 
    var property posicion = game.center()
    method position() = posicion 
    method image()
    method press()
}

class BotonOpcion inherits Boton(sprite = ["boton.png","boton_hover.png"]){
    var hover = false
    var secuencia
    override method image() = sprite.get(if (hover) 1 else 0)
    override method press(){
        secuencia.apply()
    } 
    method cambiarHover(){
        hover = !hover
    }
}

class BotonSeleccionCriatura inherits Boton(){
    var criatura
    override method image() = sprite
    override method press(){
        jugador.seleccionCriatura(criatura)
    } 
}

const botonJugar = new BotonOpcion(secuencia = {gestorPantallas.cambiarPantalla(pantallaSeleccionCriatura)})
const botonAux = new BotonOpcion(secuencia = {game.say(botonAux,"Hola Mundo")})

//Botones seleccion criatura

const botonLaoc = new BotonSeleccionCriatura(sprite = "Laoc128.png",criatura = new Laoc())
