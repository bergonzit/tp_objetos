import clases.criaturas.*
import clases.pantallaSeleccionCriatura.pantallaSeleccionCriatura
import clases.jugadores.*
import wollok.game.*
import clases.texto.*
import clases.gestorPantallas.*
import clases.botones.*

object pantallaBatalla{
    var property fondo = "fondo3.png"
    var index = 0
    var property limiteIndexActual = 0
    var estado = null

    //Botones
    var property botonesCambioCriatura = []
    var property botonesAcciones = []

    method run(){
        self.inicializarBotones()
        self.habilitarControles()
        self.cambiarEstado(combate)
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

    method mostrarCriatura(dueño){
        game.addVisual(dueño.criaturaSeleccionada())
    }

    method ocultarCriatura(dueño){
        game.removeVisual(dueño.criaturaSeleccionada())
    }

}

//Seleccion y criaturas
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
        self.mostrarBotonesCambioCriatura()
        self.actualizarLimite()
        self.mostrarSeleccion()
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
            combate.acciones().add(new Accion(tipo = "cambio", accion = {
                pantallaBatalla.ocultarCriatura(jugador)
                jugador.index(index)
                jugador.criaturaSeleccionada().posicion(game.at(12,44-jugador.criaturaSeleccionada().offsetY()))
                pantallaBatalla.mostrarCriatura(jugador)
                mostrarMensaje.cambiarValores(["seleccionCriatura",jugador.criaturaSeleccionada().nombre()])
                pantallaBatalla.cambiarEstado(mostrarMensaje)
                combate.cambiaCriatura(true)
            }))
            combate.siguienteTurno()
            pantallaBatalla.cambiarEstado(combate)
        }
    }

    method limpiarVisuales(){
        pantallaBatalla.botonesCambioCriatura().forEach({boton => game.removeVisual(boton)})
        game.removeVisual(seleccion)
    }

    method mostrarBotonesCambioCriatura(){
        pantallaBatalla.botonesCambioCriatura().forEach({boton => game.addVisual(boton)})
    }

    method mostrarSeleccion(){
        seleccion.posicion(self.obtenerPosicion(0))
        game.addVisual(seleccion)
    }
}

object rivalCambioCriatura{

    method actualizarEstado(){
        combate.acciones().add(new Accion(tipo = "cambio", accion = {
            pantallaBatalla.ocultarCriatura(cpu)
            cpu.cambiarCriatura()
            cpu.criaturaSeleccionada().posicion(game.at(100,60-cpu.criaturaSeleccionada().offsetY()))
            pantallaBatalla.mostrarCriatura(cpu)//No se si es necesario ocultar y mostrar la criatura
            mostrarMensaje.cambiarValores(["rivalSeleccionCriatura",cpu.criaturaSeleccionada().nombre()])
            pantallaBatalla.cambiarEstado(mostrarMensaje)
            combate.cambiaCriatura(true)
        }))
        combate.siguienteTurno()
        pantallaBatalla.cambiarEstado(combate)
    }
}

object mostrarMensaje{
    var contador = 0
    //Valores: tiene toda la informacion necesaria para mostrar mensajes por pantalla => 0: indice diccionarioTextos, 1..n: Informacion extra  
    var valores = []
    var texto = new Texto(posicion = game.at(4,22),limite = 140)
    var diccionarioTextos = new Dictionary()
    var listaTextos = []
    //var secuencia = null

    method cambiarValores(lista){
        valores = lista
        listaTextos = diccionarioTextos.get(valores.get(0)).apply()
        //secuencia = valores.get(1)
    }

    method actualizarEstado(){
        contador = 0
        self.ejecutarAccion(0)
    }

    method ejecutarAccion(index){
        //El index aca no se usa
        if (contador < listaTextos.size()) {
            texto.texto(listaTextos.get(contador))
            texto.mostrarTexto()
            contador += 1
        } else {
            texto.limpiarTexto()
            combate.siguienteTurno()
            pantallaBatalla.cambiarEstado(combate)
            //secuencia.apply()
        }
    }

    method initialize(){
        diccionarioTextos.put("seleccionCriatura",{["Has seleccionado a " + valores.get(1)]})
        diccionarioTextos.put("rivalSeleccionCriatura",{["El rival a seleccionado a " + valores.get(1)]})
        diccionarioTextos.put("ataque",{[valores.get(1) + " ha utilizado " + valores.get(2),self.resultadoAtaque(valores.get(3))]})
    }

    method resultadoAtaque(valor){
        var resultado
        if (valor == false){
            resultado = "Pero fallo..."
        } else {
            if (valor == 2){
                resultado = "Es super eficaz!"
            } else if (valor == 1){
                resultado = "Es eficaz"
            } else {
                resultado = "No es muy eficaz..."
            }
        }
        return resultado
    }

    method obtenerPosicion(index){
        return null
    }


}

object seleccionOpciones{
    method actualizarEstado(){
        
    }

    method actualizarLimite(){

    }

    method obtenerPosicion(index){

    }

    method ejecutarAccion(index){

    }

    method limpiarVisuales(){

    }
}

object rivalSeleccionOpciones{
    method actualizarEstado(){
        const decision = cpu.tomarDecision()
        if (decision == -1){
            combate.acciones.add(new Accion(tipo = "cambio",accion = {pantallaBatalla.cambiarEstado(rivalCambioCriatura)}))
        } else {
            combate.acciones.add(new Accion(tipo = "cambio",accion = {rivalAtaque.seleccion(decision) pantallaBatalla.cambiarEstado(rivalAtaque)}))
        }
    }
}

object rivalAtaque{
    var property seleccion = 0

    method actualizarEstado(){
        var acierta = cpu.criaturaSeleccionada().atacar(seleccion,jugador.criaturaSeleccionada())
        mostrarMensaje.cambiarValores(["ataque",cpu.criaturaSeleccionada().nombre(),cpu.criaturaSeleccionada().movimientos().get(seleccion).nombre(),if (acierta) cpu.criaturaSeleccionada().movimientos().get(seleccion).tipo().obtenerMult(jugador.criaturaSeleccionada().tipo())])
        pantallaBatalla.cambiarEstado(mostrarMensaje)
    }
}

object combate{
    var turnoSecuencia = -4
    var property acciones = []
    var ventajaJugador = true
    var finCombate = null
    var property cambiaCriatura = false
    method actualizarEstado(){
        //Seleccion inicio del combate
        if (turnoSecuencia < 0){
            if (turnoSecuencia == -4){
                pantallaBatalla.cambiarEstado(cambioCriatura)
                self.siguienteTurno()
            } else if (turnoSecuencia == -2){
                pantallaBatalla.cambiarEstado(rivalCambioCriatura)
                self.siguienteTurno()
            }
        }
        //Aplicar acciones
        if (turnoSecuencia >= 0 and turnoSecuencia < 4){
            if (turnoSecuencia == 0){
                self.siguienteTurno()
                acciones.get(if (self.ventajaDeCambio()) 1 else 0).accion().apply()
            }
            if (turnoSecuencia == 2){
                self.siguienteTurno()
                acciones.get(if (self.ventajaDeCambio()) 0 else 1).accion().apply()
            }
        }
        //Seleccion de acciones
        if (turnoSecuencia >= 4 and turnoSecuencia < 8) {
            if (cambiaCriatura) {
                self.verificarVentaja()
                cambiaCriatura = false
            }
            if (turnoSecuencia == 4){
                acciones.clear()
                self.siguienteTurno()
                pantallaBatalla.cambiarEstado(if (ventajaJugador) cambioCriatura else rivalSeleccionOpciones)
            }
            if (turnoSecuencia == 6){
                self.siguienteTurno()
                pantallaBatalla.cambiarEstado(if (ventajaJugador) rivalCambioCriatura else seleccionOpciones)
            }
        }

    }

    method ventajaDeCambio(){
        return acciones.get(1).tipo() == "cambio"
    }

    method siguienteTurno(){
        turnoSecuencia += 1
    }

    method verificarVentaja(){
        ventajaJugador = jugador.criaturaSeleccionada().velocidad() >= cpu.criaturaSeleccionada().velocidad()
    }

    method actualizarLimite(){

    }

    method obtenerPosicion(index){

    }

    method ejecutarAccion(index){

    }

    method limpiarVisuales(){

    }

}