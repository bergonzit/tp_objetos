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

class Curacion inherits Movimiento(tipo = curacion) {
    override method accion(emisor,receptor){
        emisor.restarEnergia(costo)
        emisor.sacarVida(-poder)
        return if(self.aciertaAtaque()) 1 else 0
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
    poder = 30,
    precision = 95,
    tipo = fuego
)
const llamarada = new Ataque(
    nombre = "Llamarada",
    costo = 45,
    poder = 60,
    precision = 60,
    tipo = fuego
)

const tostar = new Ataque(
    nombre = "Tostar",
    costo = 25,
    poder = 40,
    precision = 90,
    tipo = fuego
)

const concentrarTemperatura = new Curacion(
    nombre = "Concentrar Temperatura",
    costo = 80,
    poder = 80,
    precision = 100
)

const pulverizar = new Ataque(
    nombre = "Pulverizar",
    costo = 50,
    poder = 60,
    precision = 50,
    tipo = fuego
)

const fundir = new Ataque(
    nombre = "Fundir",
    costo = 30,
    poder = 45,
    precision = 85,
    tipo = fuego
)

const tsunami = new Ataque(
    nombre = "Tsunami",
    costo = 30,
    poder = 60,
    precision = 80,
    tipo = agua
)

const diluvio = new Ataque(
    nombre = "Diluvio",
    costo = 40,
    poder = 70,
    precision = 80,
    tipo = agua
)

const condensar = new Curacion(
    nombre = "Condensar",
    costo = 80,
    poder = 80,
    precision = 100
)

const pistolaDeBurbujas = new Ataque(
    nombre = "Pistola de Burbujas",
    costo = 15,
    poder = 30,
    precision = 90,
    tipo = agua
)

const rociar = new Ataque(
    nombre = "Rociar",
    costo = 20,
    poder = 40,
    precision = 95,
    tipo = agua
)

const latigoDeRaiz = new Ataque(
    nombre = "Latigo de Raiz",
    costo = 20,
    poder = 40,
    precision = 90,
    tipo = planta
)

const corteDeHojas = new Ataque(
    nombre = "Corte de Hojas",
    costo = 30,
    poder = 50,
    precision = 80,
    tipo = planta
)

const germinar = new Curacion(
    nombre = "Germinar",
    costo = 50,
    poder = 80,
    precision = 75
)


const rayoSolar = new Ataque(
    nombre = "Rayo Solar",
    costo = 40,
    poder = 70,
    precision = 60,
    tipo = planta
)

const enredar = new Ataque(
    nombre = "Enredar",
    costo = 30,
    poder = 40,
    precision = 90,
    tipo = planta
)

const cristalizar = new Ataque(
    nombre = "Cristalizar",
    costo = 30,
    poder = 45,
    precision = 80,
    tipo = normal
)

const hazDeLuz = new Ataque(
    nombre = "Haz de Luz",
    costo = 40,
    poder = 55,
    precision = 70,
    tipo = normal
)

const golpeVeloz = new Ataque(
    nombre = "Golpe Veloz",
    costo = 15,
    poder = 25,
    precision = 90,
    tipo = normal
)

const estocada = new Ataque(
    nombre = "Estocada",
    costo = 40,
    poder = 60,
    precision = 65,
    tipo = normal
)

const estus = new Curacion(
    nombre = "Estus",
    costo = 150,
    poder = 150,
    precision = 100
)

const corte = new Ataque(
    nombre = "Corte",
    costo = 25,
    poder = 40,
    precision = 80,
    tipo = normal
)

const renacer = new Curacion(
    nombre = "Renacer",
    costo = 200,
    poder = 140,
    precision = 100
)

const mordida = new Ataque(
    nombre = "Mordida",
    costo = 30,
    poder = 50,
    precision = 80,
    tipo = normal
)

const latigazo = new Ataque(
    nombre = "Latigazo",
    costo = 40,
    poder = 60,
    precision = 70,
    tipo = normal
)
