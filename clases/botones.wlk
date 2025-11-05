import gestorPantallas.gestorPantallas
import pantallaMenu.pantallaMenu
import pantallaSeleccionCriatura.pantallaSeleccionCriatura
import clases.pantallaBatalla.pantallaBatalla
import clases.jugadores.jugador
import clases.criaturas.*
import clases.texto.*
import wollok.game.*

class Boton{
    var property sprite
    var property secuencia = {}
    var property posicion = game.center()
    method position() = posicion 
    method image() = sprite
    method press()
}

class BotonOpcion inherits Boton(sprite = "boton_opciones.png"){
    override method press(){
        secuencia.apply()
    } 
}

class BotonSeleccionCriatura inherits Boton(){
    override method press(){
        return jugador.seleccionCriatura(criatura)
    }
    var property criatura = secuencia.apply()
}

//Botones acciones

const botonJugar = new BotonOpcion(sprite = "boton1.png",secuencia = {gestorPantallas.cambiarPantalla(pantallaSeleccionCriatura)})
const botonCombatir = new BotonOpcion(secuencia = {gestorPantallas.cambiarPantalla(pantallaBatalla)})

//Botones seleccion criatura

const botonLaoc = new BotonSeleccionCriatura(sprite = "Laoc128.png",secuencia = {new Laoc()})
const botonSeedy = new BotonSeleccionCriatura(sprite = "Seedy128.png",secuencia = {new Seedy()})
const botonLacui = new BotonSeleccionCriatura(sprite = "Lacui128.png",secuencia = {new Lacui()})
const botonCrigmal = new BotonSeleccionCriatura(sprite = "Crigmal128.png",secuencia = {new Crigmal()})
const botonEmblem = new BotonSeleccionCriatura(sprite = "Emblem128.png",secuencia = {new Emblem()})
const botonBloo = new BotonSeleccionCriatura(sprite = "Bloo128.png",secuencia = {new Bloo()})
const botonArgentum = new BotonSeleccionCriatura(sprite = "Argentum128.png",secuencia = {new Argentum()})
const botonSoul = new BotonSeleccionCriatura(sprite = "Soul128.png",secuencia = {new Soul()})
const botonCombust = new BotonSeleccionCriatura(sprite = "Combust128.png",secuencia = {new Combust()})
const botonPuff = new BotonSeleccionCriatura(sprite = "Puff128.png",secuencia = {new Puff()})
const botonLeefo = new BotonSeleccionCriatura(sprite = "Leefo128.png",secuencia = {new Leefo()})
const botonOuroboros = new BotonSeleccionCriatura(sprite = "Ouroboros128.png",secuencia = {new Ouroboros()})
