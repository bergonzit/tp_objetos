import clases.fondo.fondo
import clases.botones.*
object pantallaSeleccionCriatura{
    method run(){
        fondo.imagenFondo("fondo2.png")
        game.addVisual(fondo)
        game.addVisual(botonLaoc)
    }
}