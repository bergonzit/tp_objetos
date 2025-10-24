import clases.gestorPantallas.*
import clases.botones.*
import wollok.game.*
import clases.fondo.fondo
object pantallaMenu {
    var boton = botonJugar
    method run(){
        //Muestra fondo
        fondo.imagenFondo("fondo.png")
        game.addVisual(fondo)
        
        //Posiciona los botones

        game.addVisual(boton)
        boton.posicion(game.at(32,16))
        //boton.cambiarHover()

        //Controles
        keyboard.enter().onPressDo{boton.press()}
    }

}

