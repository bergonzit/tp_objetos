object jugador{
    var criaturas = []
    const maxCriaturas = 4

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
}