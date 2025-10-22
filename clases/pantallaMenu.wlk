import clases.gestorPantallas.*
import clases.botones.*
import wollok.game.*
import clases.fondo.fondo
object pantallaMenu {
    var boton = [botonJugar,botonAux]
    var seleccion = 0
    method run(){
        //Muestra fondo
        fondo.imagenFondo("fondo.png")
        game.addVisual(fondo)
        
        //Posiciona los botones
        self.ubicarBotones()
        game.addVisual(boton.get(0))
        game.addVisual(boton.get(1))
        boton.get(seleccion).cambiarHover()

        //Controles
        keyboard.up().onPressDo{self.cambiarSeleccion()}
        keyboard.down().onPressDo{self.cambiarSeleccion()}
        keyboard.enter().onPressDo{boton.get(seleccion).press()}
    }

    method ubicarBotones() {
        boton.get(0).posicion(game.at(17,15))
        boton.get(1).posicion(game.at(17,3))
    }

    method cambiarSeleccion() {
        boton.get(seleccion).cambiarHover()
        seleccion = if (seleccion == 1) 0 else 1
        boton.get(seleccion).cambiarHover()
    }
}

