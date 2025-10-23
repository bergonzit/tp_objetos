import pantallaMenu.pantallaMenu
import pantallaSeleccionCriatura.pantallaSeleccionCriatura
object gestorPantallas{
    var actual = null
    method position() = game.center()
    method run(){
       self.cargarPantalla(pantallaMenu)
    }

    method cambiarSeleccionCriatura(){
        self.cargarPantalla(pantallaSeleccionCriatura)
    }

    method cargarPantalla(pantalla){
        game.clear()
        actual = pantalla
        actual.run()
    }
}