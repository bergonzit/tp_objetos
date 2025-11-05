import clases.criaturas.*
import clases.pantallaSeleccionCriatura.pantallaSeleccionCriatura
import clases.jugadores.*
import wollok.game.*
import clases.texto.*
import clases.gestorPantallas.*
import clases.botones.*

object pantallaBatalla{
    var property fondo = "fondoBatalla.png"
    var property index = 0
    var property limiteIndexActual = 0
    var property estadoPrevio = null
    var estado = null
    var property cumpleAccion = false
    var property acciones = []
    var property stats = []

    //Botones
    var property botonesCambioCriatura = []
    var property botonesAcciones = []
    var property botonesMovimientos = []

    method run(){
        self.inicializarBotones()
        self.mostrarStats()
        self.habilitarControles()
        self.ubicarCriaturas()
        self.iniciarCombate()
    }

    method mostrarStats(){
        stats.add(new Stat(usuario = jugador, posicion = game.at(0,74),posicionTexto = game.at(3,87),posicionBarra = game.at(4,81)))
        stats.add(new Stat(usuario = cpu, posicion = game.at(88,32), posicionTexto = game.at(101,45),posicionBarra = game.at(100,39)))
        stats.forEach({stat => 
            game.addVisual(stat)
            game.addVisual(stat.barraVida())
            game.addVisual(stat.barraEnergia())
        })
    }

    method actualizarStats(){
        //Tira excepcion la primera vez que se ejecuta
        stats.forEach({stat =>
            stat.actualizarCriatura()
        })
    }

    method iniciarCombate(){
        self.acciones().add(new Accion(tipo = "cambio", accion = rivalSeleccionCriatura.secuencia()))
        self.cambiarEstado(seleccionCriatura)
    }

    method inicializarBotones(){
        self.inicializarBotonesCambioCriatura()
        self.inicializarBotonesAcciones()
        self.inicializarBotonesMovimientos()
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
            sprite = "botonAtacar.png",
            posicion = game.at(64,16)
        ))
        botonesAcciones.add(new BotonOpcion(
            sprite = "botonCambiarCriatura.png",
            posicion = game.at(64,0)
        ))
    }

    method inicializarBotonesMovimientos(){
        4.times({i => botonesMovimientos.add(new BotonOpcion(posicion = self.posicionBotonesChicos(i-1)))})
    }

    method posicionBotonesChicos(i){
        return game.at(
            if ((i+1) % 2 == 0) 104 else 64,
            if ((i+1) > 2) 0 else 16
        )
    }

    method cambiarEstado(otroEstado){
        estadoPrevio = estado
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

    method ubicarCriaturas(){
        cpu.criaturas().forEach({criatura => criatura.posicion(game.at(100,66-criatura.offsetY()))})
        jugador.criaturas().forEach({criatura => criatura.posicion(game.at(12,44-criatura.offsetY()))})
    }

    method mover(valor){
        index += valor
        self.limitarIndex()
        try {
            estado.cambiarDescripcion(index)
        } catch e : MessageNotUnderstoodException console.println("El estado " + estado + " no cuenta con el metodo Cambiar Descripcion!")
    }

    method limitarIndex(){
        if(index < 0) {
            index = 0
        } else if (index > limiteIndexActual){
            index = limiteIndexActual
        }
        try{
            seleccion.posicion(estado.obtenerPosicion(index))
        }catch e : MessageNotUnderstoodException{console.println("El estado " + estado + " no utiliza el index")}
        
    }

    method mostrarCriatura(dueño){
        game.addVisual(dueño.criaturaSeleccionada())
    }

    method ocultarCriatura(dueño){
        game.removeVisual(dueño.criaturaSeleccionada())
    }

    method ventajaDeCambio(){
        return acciones.get(1).tipo() == "cambio" and acciones.get(0).tipo() != "derrota"
    }

    method verificarVentaja(){
        return jugador.criaturaSeleccionada().velocidad() >= cpu.criaturaSeleccionada().velocidad()
    }

    method asignarAcciones(){
        acciones.clear()
        self.cambiarEstado (if (self.verificarVentaja()) seleccionAccion else rivalSeleccionAccion )
    }

    method actualizarBotonesMovimientos(){
        botonesMovimientos.size().times({i =>
            botonesMovimientos.get(i-1).sprite("boton" + jugador.criaturaSeleccionada().movimientos().get(i-1).nombre() + ".png")
        })
    }

    method verificarSaludCriaturas(){
        try{
            self.verificarSaludCriaturasUsuario(cpu)
            self.verificarSaludCriaturasUsuario(jugador)
        }catch e : MessageNotUnderstoodException{console.println("Inicio del combate")}
    }

    method verificarSaludCriaturasUsuario(usuario){
        if (!usuario.criaturaSeleccionada().estaViva() and acciones.get(0).tipo() != "derrota"){
                self.limpiarAcciones()
                acciones.add(new Accion(tipo = "derrota",accion = {
                    mostrarMensaje.cambiarValores(["fueraDeCombate",usuario.criaturaSeleccionada().nombre()])
                    self.cambiarEstado(mostrarMensaje)
                }))
                if (usuario.criaturasVivas() != 0){
                    self.cambiarEstado(if (usuario == cpu) rivalSeleccionCriatura else seleccionCriatura)
                } else {
                    self.cambiarEstado(terminarCombate)
                }
            }
    }

    method limpiarAcciones(){
        acciones.clear()
        cumpleAccion = false
    }

}

//Seleccion y varios
object seleccion{
    var property esPequeño = true
    var property posicion = null
    const imagen = ["seleccion_chica.png", "seleccion_larga.png"]
    method image() = imagen.get( if (esPequeño) 0 else 1)
    method position() = posicion
}

class Accion{
    var property tipo
    var property accion
}

class Barra{
    const tipo
    var property posicion
    var imagen = tipo + "100.png"
    method image() = imagen
    method position() = posicion

    method actualizarBarra(valor){
        const valorAprox = (valor/5).round() * 5
        imagen = tipo + valorAprox + ".png"
    }
}

class Stat{
    
    const usuario
    var criaturasVivas = null
    var imagen = null
    const posicion
    const posicionTexto
    const posicionBarra
    var property barraVida = new Barra(tipo = "vida",posicion = posicionBarra)
    var property barraEnergia = new Barra(tipo = "mana",posicion = game.at(posicionBarra.x(),posicionBarra.y()-1))
    method image() = imagen
    method position() = posicion
    const texto = new Texto(posicion = posicionTexto ,limite = 100)

    method initialize(){
        self.actualizarImagen()
        criaturasVivas = usuario.criaturasVivas()
    }

    method actualizarImagen(){
        imagen = "stats" + usuario.nombre() + usuario.criaturasVivas() + ".png"
    }

    method actualizarCriatura(){
        texto.texto(usuario.criaturaSeleccionada().nombre())
        texto.mostrarTexto()
        self.actualizarImagen()
        self.actualizarBarras()
    }

    method actualizarBarras(){
        barraVida.actualizarBarra(usuario.criaturaSeleccionada().porcentajeVidaRestante())
        barraEnergia.actualizarBarra(usuario.criaturaSeleccionada().porcentajeEnergiaRestante())
    }
}

//Estados

object mostrarMensaje{
    var contador = 0
    //Valores: tiene toda la informacion necesaria para mostrar mensajes por pantalla => 0: indice diccionarioTextos, 1..n: Informacion extra  
    var valores = []
    var property texto = new Texto(posicion = game.at(4,22),limite = 56)
    const diccionarioTextos = new Dictionary()
    var listaTextos = []

    method cambiarValores(lista){
        valores = lista
        texto.limite(140)
        listaTextos = diccionarioTextos.get(valores.get(0)).apply()
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
        } else if (valores.get(0) != "victoria" and valores.get(0) != "derrota"){
            self.mostrarTextoBase()
            if (!pantallaBatalla.cumpleAccion()) {
                pantallaBatalla.cumpleAccion(true)
                pantallaBatalla.cambiarEstado(aplicarAccion)
            } else {
                pantallaBatalla.cumpleAccion(false)
                pantallaBatalla.cambiarEstado(aplicarAccion)
            }
        }  
    }

    method mostrarTextoBase(){
            texto.limite(56)
            texto.texto("Seleccione una opcion")
            texto.mostrarTexto()
        }

    method mostrarStatsCriatura(index){
        const criatura = jugador.criaturas().get(index)
        texto.texto("Tipo:" + criatura.tipo().nombre() +
         " Vida:" + criatura.vida() + "/" + criatura.vidaMax() +
         " Mana:" + criatura.energia() + "/" + criatura.energiaMax())
        texto.mostrarTexto()
    }

    method mostrarStatsMovimiento(index){
        const movimiento = jugador.criaturaSeleccionada().movimientos().get(index)
        texto.texto("Tipo: " + movimiento.tipo().nombre() +
         " Poder: " + movimiento.poder() +
         " Costo: " + movimiento.costo())
        texto.mostrarTexto()
    }

    method initialize(){
        diccionarioTextos.put("seleccionCriatura",{["Has seleccionado a " + valores.get(1)]})
        diccionarioTextos.put("rivalSeleccionCriatura",{["El rival a seleccionado a " + valores.get(1)]})
        diccionarioTextos.put("ataque",{[valores.get(1) + " ha utilizado " + valores.get(3),self.resultadoAtaque(valores.get(2))]})
        diccionarioTextos.put("fueraDeCombate",{[valores.get(1) + " ha quedado fuera de combate"]})
        diccionarioTextos.put("victoria",{["El rival se ha quedado sin criaturas habiles","Has ganado el combate!"]})
        diccionarioTextos.put("derrota",{["Te has quedado sin criaturas habiles","Perdiste el combate..."]})
    }

    method resultadoAtaque(valor){
        var resultado
        if (valor == 0){
            resultado = "Pero fallo..."
        } else if (valor == 2){
            resultado = "Es super eficaz!"
        } else if (valor == 1){
            resultado = "Ha acertado"
        } else {
            resultado = "No es muy eficaz..."
        }
        return resultado
    }

}

object seleccionAccion {

    method actualizarEstado(){
        self.actualizarLimite()
        self.mostrarBotonesAcciones()
        self.mostrarSeleccion()
    }

    method ejecutarAccion(index){
        self.limpiarVisuales()
        pantallaBatalla.cambiarEstado(if (index == 0) seleccionMovimiento else seleccionCriatura)
    }

    method actualizarLimite(){
        pantallaBatalla.index(0)
        pantallaBatalla.limiteIndexActual(pantallaBatalla.botonesAcciones().size() - 1)
    }

    method limpiarVisuales(){
        pantallaBatalla.botonesAcciones().forEach({boton => game.removeVisual(boton)})
        game.removeVisual(seleccion)
    }

    method mostrarBotonesAcciones(){
        pantallaBatalla.botonesAcciones().forEach({boton => game.addVisual(boton)})
    }

    method obtenerPosicion(index){
        return pantallaBatalla.botonesAcciones().get(index).posicion()
    }

    method mostrarSeleccion(){
        seleccion.esPequeño(false)
        seleccion.posicion(self.obtenerPosicion(0))
        game.addVisual(seleccion)
    }

}

object seleccionCriatura{

    method actualizarEstado(){
        self.actualizarLimite()
        self.mostrarBotonesCambioCriatura()
        self.mostrarSeleccion()
        self.cambiarDescripcion(0)
    }

    method actualizarLimite(){
        pantallaBatalla.index(0)
        pantallaBatalla.limiteIndexActual(pantallaBatalla.botonesCambioCriatura().size() - 1)
    }

    method obtenerPosicion(index){
        return pantallaBatalla.botonesCambioCriatura().get(index).posicion()
    }

    method ejecutarAccion(index){
        if (jugador.criaturas().get(index).estaViva() and jugador.criaturas().get(index) != jugador.criaturaSeleccionada()){
            self.limpiarVisuales()
            const secuencia = {
                pantallaBatalla.ocultarCriatura(jugador)
                jugador.cambiarCriatura(index)
                pantallaBatalla.actualizarBotonesMovimientos()
                pantallaBatalla.mostrarCriatura(jugador)
                mostrarMensaje.cambiarValores(["seleccionCriatura",jugador.criaturaSeleccionada().nombre()])
                pantallaBatalla.cambiarEstado(mostrarMensaje)
            }
            pantallaBatalla.acciones().add(new Accion(tipo = "cambio", accion = secuencia))
            if (pantallaBatalla.acciones().size() == 1){
                pantallaBatalla.cambiarEstado(rivalSeleccionAccion)
            } else {
                pantallaBatalla.cambiarEstado(aplicarAccion)
            }
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
        seleccion.esPequeño(true)
        seleccion.posicion(self.obtenerPosicion(0))
        game.addVisual(seleccion)
    }

    method cambiarDescripcion(index){
        mostrarMensaje.mostrarStatsCriatura(index)
    }
}

object seleccionMovimiento{
    method actualizarEstado(){
        self.actualizarLimite()
        self.mostrarBotonesMovimientos()
        self.mostrarSeleccion()
        self.cambiarDescripcion(0)
    }

    method actualizarLimite(){
        pantallaBatalla.index(0)
        pantallaBatalla.limiteIndexActual(pantallaBatalla.botonesMovimientos().size() - 1)
    }

    method obtenerPosicion(index){
        return pantallaBatalla.botonesMovimientos().get(index).posicion()
    }

    method ejecutarAccion(index){
        if (jugador.criaturaSeleccionada().tieneEnergia(index)){
            self.limpiarVisuales()
            const secuencia = {
                mostrarMensaje.cambiarValores(["ataque",jugador.criaturaSeleccionada().nombre(),jugador.llamarMovimiento(index),jugador.criaturaSeleccionada().ultimoMovimiento()])
                pantallaBatalla.cambiarEstado(mostrarMensaje)
            }
            pantallaBatalla.acciones().add(new Accion(tipo = "movimiento", accion = secuencia))
            if (pantallaBatalla.acciones().size() == 1){
                pantallaBatalla.cambiarEstado(rivalSeleccionAccion)
            } else {
                pantallaBatalla.cambiarEstado(aplicarAccion)
            }
        }
    }

    method limpiarVisuales(){
        pantallaBatalla.botonesMovimientos().forEach({boton => game.removeVisual(boton)})
        game.removeVisual(seleccion)
    }

    method mostrarBotonesMovimientos(){
        pantallaBatalla.botonesMovimientos().forEach({boton => game.addVisual(boton)})
    }

    method mostrarSeleccion(){
        seleccion.esPequeño(true)
        seleccion.posicion(self.obtenerPosicion(0))
        game.addVisual(seleccion)
    }

    method cambiarDescripcion(index){
        mostrarMensaje.mostrarStatsMovimiento(index)
    }
}

object rivalSeleccionAccion {
    method actualizarEstado(){
        pantallaBatalla.cambiarEstado(if(cpu.cambiaCriatura()) rivalSeleccionCriatura else rivalSeleccionMovimiento)
    }
}

object rivalSeleccionCriatura{
    const property secuencia = {
            pantallaBatalla.ocultarCriatura(cpu)
            cpu.cambiarCriatura()
            pantallaBatalla.mostrarCriatura(cpu)
            mostrarMensaje.cambiarValores(["rivalSeleccionCriatura",cpu.criaturaSeleccionada().nombre()])
            pantallaBatalla.cambiarEstado(mostrarMensaje)
        }
    method actualizarEstado(){
        pantallaBatalla.acciones().add(new Accion(tipo = "cambio", accion = secuencia))
        if (pantallaBatalla.acciones().size() == 1){
            pantallaBatalla.cambiarEstado(seleccionAccion)
        } else {
            pantallaBatalla.cambiarEstado(aplicarAccion)
        }
    }
}

object rivalSeleccionMovimiento{
    method actualizarEstado(){
        const secuencia = {
            mostrarMensaje.cambiarValores(["ataque",cpu.criaturaSeleccionada().nombre(),cpu.llamarMovimiento(),cpu.criaturaSeleccionada().ultimoMovimiento()])
            pantallaBatalla.cambiarEstado(mostrarMensaje)
        }
        pantallaBatalla.acciones().add(new Accion(tipo = "movimiento", accion = secuencia))
        if (pantallaBatalla.acciones().size() == 1){
            pantallaBatalla.cambiarEstado(seleccionAccion)
        } else {
            pantallaBatalla.cambiarEstado(aplicarAccion)
        }

    }
}

object aplicarAccion{
    method actualizarEstado(){
        pantallaBatalla.verificarSaludCriaturas()
        if (pantallaBatalla.cumpleAccion()){
            pantallaBatalla.acciones().get(if (pantallaBatalla.ventajaDeCambio()) 0 else 1).accion().apply()
        } else if (!(pantallaBatalla.estadoPrevio() == mostrarMensaje)){
            pantallaBatalla.acciones().get(if (pantallaBatalla.ventajaDeCambio()) 1 else 0).accion().apply()
        } else{
            pantallaBatalla.asignarAcciones()
        }
        pantallaBatalla.actualizarStats()
    }
        
}

object terminarCombate{
    method actualizarEstado(){
        pantallaBatalla.acciones().add(new Accion(tipo = "fin",accion = {
            mostrarMensaje.cambiarValores([if (cpu.criaturasVivas() == 0) "victoria" else "derrota"])
            pantallaBatalla.cambiarEstado(mostrarMensaje)
        }))
    }
}
