import clases.fondo.fondo
import clases.botones.*

object pantallaSeleccionCriatura{
    const property listaBotones = [botonLaoc,botonLacui,botonSeedy,botonLaoc1,botonLaoc2,botonLaoc3,botonLaoc4,botonLaoc5]
    method run(){
        fondo.imagenFondo("fondo2.png")
        game.addVisual(fondo)
        self.colocarBotones()
        game.addVisual(seleccion)
        seleccion.habilitarSeleccion()
    }
    method colocarBotones(){
        var y = 41
        var x = 3
        var i = 0
        listaBotones.forEach({
            boton => boton.posicion(game.at(x,y))
            game.addVisual(boton)
            x += 12
            i += 1
            if  (i == 4){
                x = 3
                y -= 12
                i = 0
            }
        })
    }
}
object seleccion{
    var posicion = null
    var posiciones = []
    var index = 0
    method image() = "seleccion64.png"
    method position() = posicion
    method habilitarSeleccion(){
       self.obtenerPosiciones()
       keyboard.right().onPressDo{self.mover(1)}
       keyboard.left().onPressDo{self.mover(-1)}
       keyboard.up().onPressDo{self.mover(-4)}
       keyboard.down().onPressDo{self.mover(4)}
    }
    method obtenerPosiciones(){
        posiciones = pantallaSeleccionCriatura.listaBotones().map({boton => boton.posicion()})
        posicion = posiciones.get(index)
    }
    method mover(valor) {
      if (index + valor >= 0 && index + valor < posiciones.size()){
        index += valor
        posicion = posiciones.get(index)
      }
    }

}