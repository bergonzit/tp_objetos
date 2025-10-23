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
        if (self.tieneCriatura(criatura)) 
            self.quitarCriatura(criatura) 
        else if (criaturas.size() < maxCriaturas) 
            self.agregarCriatura(criatura)
    }
}