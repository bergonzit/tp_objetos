import clases.gestorPantallas.*
import clases.botones.*
import wollok.game.*
import clases.fondo.fondo
import clases.texto.*
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

        //Ejemplo de texto con fuente
        var texto = new Texto(posicion = game.center(), limite = 50)
        texto.inicializar() //Tiene que ejecutarse si o si, buscar manera de precargar el diccionario
        texto.texto("Texto Centrado")
        texto.mostrarTexto()
        texto.centrar()
    }

}

