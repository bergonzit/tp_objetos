import clases.jugadores.*
import wollok.game.*
import clases.texto.*
import clases.gestorPantallas.*
import clases.botones.*

object pantallaBatalla{
    var property fondo = "fondo3.png"
    var acciones = []
    var index = 0
    var turnoJugador = true

    //Botones seleccion criatura
    var botonesCambioCriatura = []

    method run(){
        self.inicializarBotonesCambioCriatura()
        self.seleccionarCriaturaInicial()
        self.seleccionarAccion()
    }

    method inicializarBotonesCambioCriatura(){
        jugador.criaturas().size().times({i => 
            botonesCambioCriatura.add(new BotonCambioCriatura(
                secuencia = i-1,
                valorTexto = jugador.criaturas().get(i-1).nombre(),
                posicion = self.posicionBotonCambioCriatura(i-1)))
        })
    }

    method posicionBotonCambioCriatura(i){
        return game.at(
            if ((i+1) % 2 == 0) 104 else 64,
            if ((i+1) > 2) 0 else 16
        )
    }

    method seleccionarCriaturaInicial(){
        self.agregarSeleccion()
    }

    method agregarSeleccion(){
        self.actualizarPosicionSeleccion()
        game.addVisual(seleccion)
    }

    method actualizarPosicionSeleccion(){
        seleccion.posicion(self.posicionBotonCambioCriatura(index))
    }
    

    method seleccionarAccion(){
    }

}

object seleccion{
    var property posicion = null
    var imagen = "seleccion_chica.png"
    method image() = imagen
    method position() = posicion
}

class Accion{
    var property tipo
    var property accion
}