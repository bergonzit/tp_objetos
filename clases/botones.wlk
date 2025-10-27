import gestorPantallas.gestorPantallas
import pantallaMenu.pantallaMenu
import pantallaSeleccionCriatura.pantallaSeleccionCriatura
import clases.jugadores.jugador
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
    var property secuencia
    var property posicion = game.center()
    method position() = posicion 
    method image()
    method press()
}

class BotonOpcion inherits Boton(sprite = "boton_opciones.png"){
    
    override method image() = sprite
    override method press(){
        secuencia.apply()
    } 
}

class BotonSeleccionCriatura inherits Boton(){
    
    override method image() = sprite
    override method press(){
        return jugador.seleccionCriatura(criatura)
    }
    var property criatura = secuencia.apply()
}

const botonJugar = new BotonOpcion(sprite = "boton1.png",secuencia = {gestorPantallas.cambiarPantalla(pantallaSeleccionCriatura)})
const botonCombatir = new BotonOpcion(secuencia = {})

//Botones seleccion criatura

const botonLaoc = new BotonSeleccionCriatura(sprite = "Laoc128.png",secuencia = {new Laoc()})
const botonSeedy = new BotonSeleccionCriatura(sprite = "Seedy128.png",secuencia = {new Seedy()})
const botonLacui = new BotonSeleccionCriatura(sprite = "Lacui128.png",secuencia = {new Lacui()})
const botonCrigmal = new BotonSeleccionCriatura(sprite = "Crigmal128.png",secuencia = {new Crigmal()})
const botonArgentum = new BotonSeleccionCriatura(sprite = "Argentum128.png",secuencia = {new Argentum()})
const botonSoul = new BotonSeleccionCriatura(sprite = "Soul128.png",secuencia = {new Soul()})
