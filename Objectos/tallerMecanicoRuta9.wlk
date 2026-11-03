class Vehiculo{
    const patente
    var kilometrosRecorridos
    var reparacionesPendientes = []

    method agregarReparaciones(reparacion){ 
        reparacionesPendientes.add(reparacion)
        }

    method cuantasReparacionesTengo() = reparacionesPendientes.size()

    method necesitaRevision() = kilometrosRecorridos > 100000 || 
        reparacionesPendientes.any({reparacion => reparacion.reparacionCara()})
    
    method costoTotal(){
        reparacionesPendientes.map({reparaciones => reparaciones.costoFinal()}).sum()
    }

    method estaBaqueteado() = kilometrosRecorridos > 150000 

    method susReparcionesCaras()= reparacionesPendientes.map({reparaciones => reparaciones.reparcionCara(self)})
}

class Reparaciones{
    var costoBase
    var horasArreglo

    method costoFinal() = costoBase

    method reparacionCara() = self.costoFinal() > 50000
}

class reparacionesMecanicas inherits Reparaciones {
    var dificultad

    override method costoFinal() = costoBase + (5000 * dificultad)
}

class reparacionesElectricas inherits Reparaciones {
    var componentesAfectados 

    override method costoFinal() = costoBase + (3000 * componentesAfectados) 
}


const golTrend = new Vehiculo(
    patente = "AA111AA",
    kilometrosRecorridos = 90000
)

const hilux = new Vehiculo(
    patente = "AB222BB",
    kilometrosRecorridos = 170000
)

const cambioDistribucion = new reparacionesMecanicas (
    dificultad = 4,
    costoBase = 40000,
    horasArreglo = 5
)

const problemaAlternador = new reparacionesElectricas (
    componentesAfectados = 4,
    costoBase = 25000,
    horasArreglo = 3
)

const cambioAceite = new reparacionesMecanicas (
    dificultad = 1,
    costoBase = 15000,
    horasArreglo = 1
)