import clases.botones.*
import wollok.game.*


object pantallaMenu {
    var boton = [new Boton(),new Boton()]
    var seleccion = 0
    method run(){
        game.boardGround("fondo.png")
        self.ubicarBotones()
        game.addVisual(boton.get(0))
        game.addVisual(boton.get(1))
        keyboard.enter().onPressDo{boton.get(seleccion).press()}
    }

    method ubicarBotones() {
        boton.get(0).posicion(game.at(17,15))
        boton.get(1).posicion(game.at(17,3))
    }
}

