import pantallaMenu.pantallaMenu
import pantallaSeleccionCriatura.pantallaSeleccionCriatura
object gestorPantallas{
    var actual = pantallaMenu
    method position() = game.center()
    method run(){
        game.clear()
        actual.run()
    }
    method cambiarSeleccionCriatura(){
        game.clear()
        actual = pantallaSeleccionCriatura
        actual.run()
    }
}