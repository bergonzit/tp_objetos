import clases.pantallaBatalla.*
import clases.botones.*
object jugador{
    var property criaturaSeleccionada = null
    var property criaturas = []
    const property maxCriaturas = 4

    method agregarCriatura(criatura){
        criaturas.add(criatura)
    }

    method quitarCriatura(criatura){
        criaturas.remove(criatura)
    }

    method tieneCriatura(criatura){
        return criaturas.contains(criatura)
    }

    method cambiarCriatura(index){
        criaturaSeleccionada = criaturas.get(index)
    }

    method seleccionCriatura(criatura){
        var cambia = true // Se usa para marcar la seleccion
        if (self.tieneCriatura(criatura)) 
            self.quitarCriatura(criatura) 
        else if (criaturas.size() < maxCriaturas) 
            self.agregarCriatura(criatura)
        else cambia = false
        return cambia
    }

    method llamarMovimiento(index){
        return criaturaSeleccionada.atacar(criaturaSeleccionada.movimientos().get(index),cpu.criaturaSeleccionada())
    }

}

object cpu{
    var property criaturaSeleccionada = null
    var property criaturas = []
    const property maxCriaturas = 4

    method agregarCriatura(criatura){
        criaturas.add(criatura)
    }

    method cambiarCriatura(){
        criaturaSeleccionada = criaturas.filter({criatura => criatura.estaViva() and criatura != criaturaSeleccionada}).randomized().get(0)
    }


    method cambiaCriatura(){
        return if (self.criaturasVivas() >= 2) (0.randomUpTo(100) < (100 - self.criaturaSeleccionada().porcentajeVidaRestante())/2) else false
    }

    method criaturasVivas(){
        return criaturas.filter({criatura => criatura.estaViva()}).size()
    }

    method llamarMovimiento(){
        return criaturaSeleccionada.atacar(criaturaSeleccionada.movimientosDisponibles().randomized().get(0),jugador.criaturaSeleccionada())
    }

}