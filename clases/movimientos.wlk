import tipos.*
class Movimiento {
    const property nombre
    const property costo
    const property poder
    const property precision
    const property tipo
    

    method accion(criaturaObjetivo) {
        if(precision >= 0.randomUpTo(precision))
            criaturaObjetivo.sacarVida(poder * tipo.obtenerMult(criaturaObjetivo.tipo()))
    }
}

const placaje = new Movimiento(
    nombre = "Placaje",
    costo = 10,
    poder = 15,
    precision = 100,
    tipo = normal
)

