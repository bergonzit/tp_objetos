import clases.gestorPantallas.*
import clases.fondo.fondo
import clases.pantallaBatalla.pantallaBatalla
import clases.botones.*
import clases.texto.*
import clases.jugadores.*
import wollok.game.*

object pantallaSeleccionCriatura{
    var property fondo = "fondo2.png"
    const property listaBotones = [botonLaoc,botonLacui,botonSeedy,botonCrigmal,botonEmblem,botonBloo,botonArgentum,botonSoul,botonCombust,botonPuff,botonLeefo,botonOuroboros]
    var textoBotonCombatir = new Texto(posicion = game.at(48,9),limite = 90)

    method run(){
        self.colocarBotones()
        self.colocarSeleccion()
        self.agregarInformacionCriatura()
    }

    method agregarInformacionCriatura(){
        game.addVisual(informacionCriatura)
        game.addVisual(imagenCriatura)
    }

    method colocarSeleccion() {
        game.addVisual(seleccion)
        seleccion.habilitarSeleccion()
    }

    method colocarBotones(){
        self.ubicarBotonesCriaturas()
        self.prepararBotonCombatir()
    }

    method prepararBotonCombatir(){
        botonCombatir.posicion(game.at(8,4))
        game.addVisual(botonCombatir)
        self.actualizarInformacionCombatir()
    }

    method actualizarInformacionCombatir(){
        var texto = ""
        if (!self.criaturasCompletas()){
            textoBotonCombatir.texto(jugador.criaturas().size().toString() + "/" + jugador.maxCriaturas().toString())
        } else {
            textoBotonCombatir.texto("Iniciar Combate")
        }
        textoBotonCombatir.mostrarTexto()
        textoBotonCombatir.centrar()
    }

    method criaturasCompletas(){
        return jugador.criaturas().size() == jugador.maxCriaturas()
    }

    method ubicarBotonesCriaturas(){
        var y = 72
        var x = 10
        const desplazamiento = 20
        var i = 0
        //Ubica botones en la cuadricula
        listaBotones.forEach({
            boton => boton.posicion(game.at(x,y))
            game.addVisual(boton)
            x += desplazamiento
            i += 1
            if  (i == 4){
                x = 10
                y -= desplazamiento
                i = 0
            }
        })
    }

     

    method iniciarCambioPantalla(){
        self.asignarCriaturasRivales()
        botonCombatir.press()
    }

    method asignarCriaturasRivales(){
        var listaIndexes = self.obtenerListaIndexes()
        listaIndexes.forEach({index => 
            cpu.agregarCriatura(listaBotones.get(index).secuencia().apply())
        })
        cpu.criaturas().forEach({criatura => criatura.esDeJugador(false)})
    }

    method obtenerListaIndexes(){
        return (0..listaBotones.size() - 1).asList().randomized().take(cpu.maxCriaturas())
    }

}

object seleccion{
    var posicion = null
    var property posiciones = []
    var property index = 0
    var marcas = []
    var property criaturaActual = null
    var property ultimoBoton = false
    var property imagen = ["seleccion128.png","seleccion_boton.png"]
    method image() = imagen.get(if (ultimoBoton) 1 else 0)
    method position() = posicion
    method habilitarSeleccion(){
        self.obtenerPosiciones()
        self.criaturaActual(pantallaSeleccionCriatura.listaBotones().get(index).criatura())
        keyboard.right().onPressDo{self.mover(1)}
        keyboard.left().onPressDo{self.mover(-1)}
        keyboard.up().onPressDo{self.mover(if (ultimoBoton) -1 else -4)}
        keyboard.down().onPressDo{self.mover(4)}
        keyboard.enter().onPressDo{self.accionarBoton()}
        informacionCriatura.actualizarInformacion(criaturaActual)
    }
    method accionarBoton(){
        if (ultimoBoton and pantallaSeleccionCriatura.criaturasCompletas()){
            pantallaSeleccionCriatura.iniciarCambioPantalla()
        }else {
            self.seleccionarBoton()
        }
    } 


    method seleccionarBoton(){
        if(pantallaSeleccionCriatura.listaBotones().get(index).press()){
            var marca
            if(marcas.any({m => m.index() == index})){
                marca = marcas.find({m => m.index() == index})
                marcas.remove(marca)
                game.removeVisual(marca)
            } else {
                marca = new MarcaSeleccion(posicion = posiciones.get(index),index = index)
                marcas.add(marca)
                game.addVisual(marca)
            }
            pantallaSeleccionCriatura.actualizarInformacionCombatir()
        }
    }
    method obtenerPosiciones(){
        posiciones = pantallaSeleccionCriatura.listaBotones().map({boton => boton.posicion()})
        posicion = posiciones.get(index)
        posiciones.add(botonCombatir.posicion())
    }
    method mover(valor) {
        index += valor
        self.limitarIndex()
        self.controlarSpriteSeleccion()
        
        posicion = posiciones.get(index)

        //Mostrar Info
        if (!ultimoBoton){
            self.criaturaActual(pantallaSeleccionCriatura.listaBotones().get(index).criatura())
            informacionCriatura.actualizarInformacion(criaturaActual)
        }
    }

    method controlarSpriteSeleccion(){
        if (index == posiciones.size() - 1 ){
            ultimoBoton = true
        } else {
            ultimoBoton = false
        }
    }

    method limitarIndex(){
        if(index < 0) {
            index = 0
        } else if (index > posiciones.size() - 1 ){
            index = posiciones.size() -1
        }
    }
}

class MarcaSeleccion{
    var posicion
    var property index
    method image() = "marca128.png"
    method position() = posicion
}

object informacionCriatura{
    var nombreCriatura = new Texto(posicion = game.at(120,81),limite = 90)
    var imagen = ""
    var posicion = game.at(109,7)
    method image() = imagen
    method position() = posicion


    method actualizarInformacion(criatura) {
        nombreCriatura.texto(criatura.nombre())
        imagenCriatura.imagen(criatura.sprite().get(0))
        imagen = criatura.tipo().imagen()
        nombreCriatura.mostrarTexto()
        nombreCriatura.centrar()
    }
}

object imagenCriatura{
    var property imagen = ""
    method image() = imagen
    method position() = game.at(104,32)
}