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
        var y = 72
        var x = 10
        var i = 0
        listaBotones.forEach({
            boton => boton.posicion(game.at(x,y))
            game.addVisual(boton)
            x += 20
            i += 1
            if  (i == 4){
                x = 10
                y -= 20
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
    method image() = "seleccion128.png"
    method position() = posicion
    method habilitarSeleccion(){
       self.obtenerPosiciones()
       keyboard.right().onPressDo{self.mover(1)}
       keyboard.left().onPressDo{self.mover(-1)}
       keyboard.up().onPressDo{self.mover(-4)}
       keyboard.down().onPressDo{self.mover(4)}
       keyboard.enter().onPressDo{self.seleccionarBoton()}
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
        }
        posicion = posiciones.get(index)
    }
}

class MarcaSeleccion{
    var posicion
    var property index
    method image() = "marca128.png"
    method position() = posicion
}