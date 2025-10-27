import pantallaMenu.pantallaMenu
import pantallaSeleccionCriatura.pantallaSeleccionCriatura
import pantallaBatalla.pantallaBatalla
import clases.fondo.fondo

object gestorPantallas{
    var actual = pantallaMenu
    method position() = game.center()
    method run(){
        game.clear()
        self.cambiarFondo(actual.fondo())
        actual.run()
    }

    method cambiarPantalla(pantalla){
        actual = pantalla
        self.run()
    }

    method cambiarFondo(imagen){
        fondo.imagenFondo(imagen)
        game.addVisual(fondo)
    }
}    

