import clases.pantallaSeleccionCriatura.*
import clases.gestorPantallas.*
import clases.botones.*
import wollok.game.*
import clases.fondo.fondo
import clases.texto.*
object pantallaMenu {
    var property fondo = "fondo.png"
    const boton = botonJugar
    method run(){  
        //Posiciona los botones

        game.addVisual(boton)
        boton.posicion(game.at(32,16))
        //boton.cambiarHover()

        //Controles
        keyboard.enter().onPressDo{boton.press()}
        //Ejemplo de texto con fuente
        //var texto = new Texto(posicion = game.center(), limite = 50)
        //texto.texto("Texto Centrado")
        //texto.mostrarTexto()
        //texto.centrar()
    }

}

