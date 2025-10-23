import gestorPantallas.gestorPantallas
import pantallaMenu.pantallaMenu
import pantallaSeleccionCriatura.pantallaSeleccionCriatura
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

class Boton{
    var sprite = ["boton.png","boton_hover.png"]
    var property posicion = game.center()
    var pantalla
    method position() = posicion 
    var hover = false
    method image() = sprite.get(if (hover) 1 else 0)
    method press(){
        gestorPantallas.cambiarPantalla(pantalla)
    } 
    //method press()
    method cambiarHover(){
        hover = !hover
    }

}

const botonJugar = new Boton(pantalla = pantallaSeleccionCriatura)
const botonAux = new Boton(pantalla = pantallaMenu)




