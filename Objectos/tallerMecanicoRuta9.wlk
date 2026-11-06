import Objectos.taller.*
class Autoo {
    const patente
    var kilometrosRecorridos
    const property reparacionesPendientes = []

    method agregarReparaciones(reparacion){ 
        reparacionesPendientes.add(reparacion)
        }

    method cuantasReparacionesTengo() = reparacionesPendientes.size()

    method necesitaRevision() = kilometrosRecorridos > 100000 || 
        reparacionesPendientes.any({reparacion => reparacion.reparacionCara()})
    
    method costoTotal()= reparacionesPendientes.map({reparaciones => reparaciones.costoFinal()}).sum()
    

    method estaBaqueteado() = kilometrosRecorridos > 150000 

    method susReparcionesCaras()= reparacionesPendientes.filter({reparaciones => reparaciones.reparacionCara()})

    method sacarReparacion(reparacion){
        reparacionesPendientes.remove(reparacion)
    }
}

class Reparaciones {
    var costoBase
    var property horasArreglo

    method costoFinal() = costoBase

    method reparacionCara() =
        self.costoFinal() > 50000

    method esMecanica() = false

    method esElectrica() = false
}

class reparacionesMecanicas inherits Reparaciones {
    var dificultad

    override method costoFinal() =
        costoBase + (5000 * dificultad)

    override method esMecanica() = true
}

class reparacionesElectricas inherits Reparaciones {
    var componentesAfectados

    override method costoFinal() =
        costoBase + (3000 * componentesAfectados)

    override method esElectrica() = true
}

class Mecanico {
    const nombre
    var horasDisponibles
    const reparacionesYaRealizadas = []

    method hacerReparacion(vehiculo, reparacion) {
        if (self.puedeReparar(reparacion)) {
            if (horasDisponibles >= reparacion.horasArreglo()) {
                horasDisponibles = horasDisponibles - reparacion.horasArreglo()
                vehiculo.sacarReparacion(reparacion)
                self.reparacionYaTerminada(reparacion)
            }
        } else {
            throw new DomainException(
                message = "El mecanico no puede realizar esta reparacion"
            )
        }
    }

    method reparacionYaTerminada(reparacion) {
        reparacionesYaRealizadas.add(reparacion)
    }

    method mecanicoExperto() =
        reparacionesYaRealizadas.size() > 5

    method puedeReparar(reparacion) = false
}

class mecanicoMecanico inherits Mecanico {
    override method puedeReparar(reparacion) =
        reparacion.esMecanica()
}

class mecanicoElectricista inherits Mecanico {
   override  method puedeReparar(reparacion) =
        reparacion.esElectrica()
}

class mecanicoGeneralista inherits Mecanico {
    override method puedeReparar(reparacion) = true
}

object taller{
    const vehiculos = []
    const mecanicos = []


    method agregarVehiculos(vehiculo){
        vehiculos.add(vehiculo)
    }
    
    method agregarMecanico(mecanico){
        mecanicos.add(mecanico)
    }

    method vehciulosEnTaller() = vehiculos.size()

    method vehiculosRevision(){
        vehiculos.filter({vehiculo => vehiculo.necesitaRevision()}).size()
    }

    method vehiculosMuyUsados(){
        vehiculos.filter({vehiculo => vehiculo.estaBaqueteado()})
    }
    
    method mecanicosExperimentado(){
        mecanicos.filter({mecanico => mecanico.mecanicoExperto()})
    }

    method costoTotalReparaciones(){
        vehiculos.map({vehiculo => vehiculo.reparacionesPendientes()}).sum()
    }

    method reparacionesCaras() =
    vehiculos.map({ vehiculo => vehiculo.reparacionesPendientes() }).flatten().
    filter({ reparacion => reparacion.reparacionCara() })

    method puedeRealizarla(reparacion){
        mecanicos.any({mecanico => mecanico.puedeReparar(reparacion)})
    }
}


const bmw = new Autoo(
    patente = "AA111AA",
    kilometrosRecorridos = 90000
)

const hilux = new Autoo(
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

const raul = new mecanicoMecanico (
    nombre = "Raul",
    horasDisponibles = 40
)

const martin = new mecanicoElectricista (
    nombre = "Martin",
    horasDisponibles = 15
)

const sofia = new mecanicoGeneralista(
    nombre = "Sofia",
    horasDisponibles = 30
)