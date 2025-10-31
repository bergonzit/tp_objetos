import tipos.*
class Movimiento {
    const property nombre
    const property costo
    const property poder
    const property precision
    const property tipo
    

    method accion(dueño,objetivo)
    method aciertaAtaque(){
        return precision >= 0.randomUpTo(100)
    }
}

class Ataque inherits Movimiento {
    override method accion(emisor,receptor){
        emisor.restarEnergia(costo)
        const acierta = self.aciertaAtaque()
        if( acierta )
            receptor.sacarVida(poder * tipo.obtenerMult(receptor.tipo()))
        return acierta
    }
}

const placaje = new Ataque(
    nombre = "Placaje",
    costo = 10,
    poder = 15,
    precision = 100,
    tipo = normal
)

