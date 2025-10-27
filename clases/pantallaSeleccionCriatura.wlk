import clases.fondo.fondo
import clases.botones.*
import clases.texto.*

object pantallaSeleccionCriatura{
    //Hay que acomodar el codigo
    const property listaBotones = [botonLaoc,botonLacui,botonSeedy,botonCrigmal,botonArgentum]
    method run(){
        fondo.imagenFondo("fondo2.png")
        game.addVisual(fondo)
        self.colocarBotones()
        game.addVisual(seleccion)
        seleccion.habilitarSeleccion()
        game.addVisual(informacionCriatura)
        game.addVisual(imagenCriatura)
        game.addVisual(botonCombatir)
        botonCombatir.posicion(game.at(8,4))
    }

    method colocarBotones(){
        var y = 72
        var x = 10
        const desplazamiento = 20
        var i = 0
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
}

object seleccion{
    var posicion = null
    var posiciones = []
    var index = 0
    var marcas = []
    var property criaturaActual = null
    method image() = "seleccion128.png"
    method position() = posicion
    method habilitarSeleccion(){
       self.obtenerPosiciones()
       self.criaturaActual(pantallaSeleccionCriatura.listaBotones().get(index).criatura())
       keyboard.right().onPressDo{self.mover(1)}
       keyboard.left().onPressDo{self.mover(-1)}
       keyboard.up().onPressDo{self.mover(-4)}
       keyboard.down().onPressDo{self.mover(4)}
       keyboard.enter().onPressDo{self.seleccionarBoton()}
        informacionCriatura.actualizarInformacion(criaturaActual)
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
        }
    }
    method obtenerPosiciones(){
        posiciones = pantallaSeleccionCriatura.listaBotones().map({boton => boton.posicion()})
        posicion = posiciones.get(index)
    }
    method mover(valor) {
        index += valor
        if(index < 0) {
            index = 0
        } else if (index > posiciones.size() - 1 ){ //Sacar el -1 cuando termine el botonBatalla
            index = posiciones.size() -1
        } else {
            //Hacer boton de batalla
        }
        posicion = posiciones.get(index)

        //Mostrar Info
        self.criaturaActual(pantallaSeleccionCriatura.listaBotones().get(index).criatura())
        informacionCriatura.actualizarInformacion(criaturaActual)
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
        imagenCriatura.imagen(criatura.sprite())
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