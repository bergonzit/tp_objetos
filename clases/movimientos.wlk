import tipos.*
class Movimiento {
    var nombre
    var costo
    var poder
    var tipo
    

    method accion(criaturaAtacante, criaturaRecibe) {
        if (criaturaAtacante.energia() >= costo) {
            criaturaAtacante.energia(criaturaAtacante.energia() - costo)
            criaturaAtacante.sacarVida(poder * tipo.obtenerMult(criaturaRecibe.tipo()))
        
        } 
    }
}