import clases.criaturas.*
import clases.pantallaSeleccionCriatura.pantallaSeleccionCriatura
import clases.jugadores.*
import wollok.game.*
import clases.texto.*
import clases.gestorPantallas.*
import clases.botones.*

object pantallaBatalla{
    var property fondo = "fondo3.png"
    var acciones = []
    var index = 0
    var property limiteIndexActual = 0
    var turnoJugador = null
    var estado = null

    //Botones
    var property botonesCambioCriatura = []
    var property botonesAcciones = []

    method run(){
        self.inicializarBotones()
        self.habilitarControles()
        self.cambiarEstado(cambioCriatura)
    }

    method inicializarBotones(){
        self.inicializarBotonesCambioCriatura()
        self.inicializarBotonesAcciones()
    }

    method inicializarBotonesCambioCriatura(){
        jugador.criaturas().size().times({i => 
            botonesCambioCriatura.add(new BotonOpcion(
                secuencia = 0, //No se usa la secuencia
                sprite = "boton" + jugador.criaturas().get(i-1).nombre() + ".png",
                posicion = self.posicionBotonesChicos(i-1)))
            
        })
    }

    method inicializarBotonesAcciones(){
        botonesAcciones.add(new BotonOpcion(
            secuencia = null,
            sprite = "botonAtacar.png",
            posicion = game.at(64,16)
        ))
        botonesAcciones.add(new BotonOpcion(
            secuencia = null,
            sprite = "botonCambiarCriatura.png",
            posicion = game.at(64,0)
        ))
    }

    method posicionBotonesChicos(i){
        return game.at(
            if ((i+1) % 2 == 0) 104 else 64,
            if ((i+1) > 2) 0 else 16
        )
    }

    method cambiarEstado(otroEstado){
        estado = otroEstado
        estado.actualizarEstado()
    }

    method habilitarControles(){
        keyboard.right().onPressDo{self.mover(1)}
        keyboard.left().onPressDo{self.mover(-1)}
        keyboard.up().onPressDo{self.mover(-(limiteIndexActual/2).round())}
        keyboard.down().onPressDo{self.mover((limiteIndexActual/2).round())}
        keyboard.enter().onPressDo({estado.ejecutarAccion(index)})
    }

    method mover(valor){
        index += valor
        self.limitarIndex()
    }

    method limitarIndex(){
        if(index < 0) {
            index = 0
        } else if (index > limiteIndexActual){
            index = limiteIndexActual
        }
        seleccion.posicion(estado.obtenerPosicion(index))
    }

}

object seleccion{
    var esPequeño = true
    var property posicion = null
    var imagen = ["seleccion_chica.png","seleccion_grande.png"]
    method image() = imagen.get( if (esPequeño) 0 else 1)
    method position() = posicion
}

//Va a ser util para cambiar de criatura (si) o seleccionar un ataque (creo)
class Accion{
    var property tipo
    var property accion
}

//Estados
object cambioCriatura{

    method actualizarEstado(){
        seleccion.posicion(self.obtenerPosicion(0))
        game.addVisual(seleccion)
        pantallaBatalla.botonesCambioCriatura().forEach({boton => game.addVisual(boton)})
        self.actualizarLimite()
    }

    method actualizarLimite(){
        pantallaBatalla.limiteIndexActual(pantallaBatalla.botonesCambioCriatura().size() - 1)
    }

    method obtenerPosicion(index){
        return pantallaBatalla.botonesCambioCriatura().get(index).posicion()
    }

    method ejecutarAccion(index){
        if (jugador.criaturas().get(index).estaViva()){
            self.limpiarVisuales()
            jugador.index(index)
            mostrarMensaje.cambiarValores(["seleccionCriatura",jugador.criaturaSeleccionada().nombre()]) //Aca ponele un valor flaco
            pantallaBatalla.cambiarEstado(mostrarMensaje)
        }
    }

    method limpiarVisuales(){
        pantallaBatalla.botonesCambioCriatura().forEach({boton => game.removeVisual(boton)})
        game.removeVisual(seleccion)
    }
}

object mostrarMensaje{
    var contador = 0
    //Valores: tiene toda la informacion necesaria para mostrar mensajes por pantalla
    var valores = [null,null,null,null,null]
    var texto = new Texto(posicion = game.at(2,24),limite = 140)
    var textos = new Dictionary()

    method cambiarValores(lista){
        valores = lista
    }
    method actualizarEstado(){
        contador = 0
        self.ejecutarAccion(0)
    }

    method ejecutarAccion(index){
        //El index aca no se usa
        if (contador < textos.get(valores.get(0)).size()) {
            texto.texto(textos.get(valores.get(0)).get(contador))
            texto.mostrarTexto()
            contador += 1
        } else {
            texto.limpiarTexto()
        }
    }

    method limpiarVisuales(){
        
    }

    method initialize(){
        textos.put("seleccionCriatura",["Has seleccionado a " + valores.get(1), "Este es solo para testear maquina"])
    }

    method obtenerPosicion(index){
        return null
    }


}