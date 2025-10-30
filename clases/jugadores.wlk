import clases.pantallaBatalla.*
import clases.botones.*
object jugador{
    var property index = 0
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

    method seleccionCriatura(criatura){
        var cambia = true // Se usa para marcar la seleccion
        if (self.tieneCriatura(criatura)) 
            self.quitarCriatura(criatura) 
        else if (criaturas.size() < maxCriaturas) 
            self.agregarCriatura(criatura)
        else cambia = false
        return cambia
    }

    method criaturaSeleccionada(){
        return criaturas.get(index)
    }
}

object cpu{
    var property index = 0
    var property criaturas = []
    const property maxCriaturas = 4

    method agregarCriatura(criatura){
        criaturas.add(criatura)
    }

    method criaturaSeleccionada(){
        return criaturas.get(index)
    }

    method cambiarCriatura(){
        //Implementacion horrible, mejorar el codigo
        self.criaturaAleatoria()
    }

    method criaturaAleatoria(){
        var valor = 0.randomUpTo(criaturas.size()-1)
        if (valor == index or !criaturas.get(valor).estaViva()){
            self.criaturaAleatoria()
        }else{
            index = valor
        }
    }
}