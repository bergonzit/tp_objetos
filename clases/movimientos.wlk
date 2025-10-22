import tipos.*
class Movimiento {
    var nombre
    var costo
    var poder
    var tipo
    

    method accion(criaturaAtacante, criaturaObjetivo) {
        criaturaAtacante.restarEnergia(costo)
        criaturaObjetivo.sacarVida(poder * tipo.obtenerMult(criaturaObjetivo.tipo()))
    }

    method costoEnergia() {
        return costo
    }
}

const placaje = new Movimiento(
    nombre = "Placaje",
    costo = 10,
    poder = 15,
    tipo = normal
)

