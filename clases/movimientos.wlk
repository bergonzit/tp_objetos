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
        const multiplicador = if(self.aciertaAtaque()) tipo.obtenerMult(receptor.tipo()) else 0
        receptor.sacarVida(poder * multiplicador)
        return multiplicador
        }
        
    }

//Movimientos
//Los movimientos base (el primero de cada criatura, deben tener 0 de coste)
const placaje = new Ataque(
    nombre = "Placaje",
    costo = 0,
    poder = 15,
    precision = 100,
    tipo = normal
)
const calentar = new Ataque(
    nombre = "Calentar",
    costo = 15,
    poder = 20,
    precision = 80,
    tipo = fuego
)

