class Vehiculo {   
    const patente
    var kilometros 
    var estadoMotor
    var reparaciones = []

    method aplicarReparacion(reparacion) {
        reparaciones.add(reparacion)
    }

    method kilometros() = kilometros

    method costoTotalDeReparacion() = reparaciones.map({ reparacion => reparacion.costoFinal() }).sum()

    method vehiculoMuyUsado() = kilometros > 150000

    method necesitaRevision() =  estadoMotor == "malo" || kilometros > 100000

    method reparacionesCaras() = reparaciones.filter({ reparacion => reparacion.reparacionCara() })
}


class Auto inherits Vehiculo {}


class Camioneta inherits Vehiculo {
    override method costoTotalDeReparacion() =
        super() + 15000
}


const hilux = new Camioneta(
    patente = "AB222BB",
    kilometros = 170000,
    estadoMotor = "malo"
)


const golTrend = new Auto(
    patente = "AA111AA",
    kilometros = 90000,
    estadoMotor = "regular"
)


class Reparacion {
    const descripcion
    var costoBase
    var horasDeTrabajo

    method costoFinal() = costoBase

    method reparacionCara() = self.costoFinal() > 50000
}


class ReparacionComun inherits Reparacion {
    override method costoFinal() =
        costoBase
}


class ReparacionUrgente inherits Reparacion {
    override method costoFinal() =
        costoBase * 1.5
}


class ReparacionCompleja inherits Reparacion {
    override method costoFinal() =
        costoBase + 20000
}


const cambioDeAceite = new ReparacionComun(
    descripcion = "Reparacion de Aceite",
    costoBase = 15000,
    horasDeTrabajo = 1
)


const cambioDeDistribucion = new ReparacionUrgente(
    descripcion = "Reparacion de la Distribucion",
    costoBase = 60000,
    horasDeTrabajo = 5
)


const reparacionDeCaja = new ReparacionCompleja(
    descripcion = "Reparacion de caja",
    costoBase = 80000,
    horasDeTrabajo = 8
)


object taller {
    var vehiculosDelTaller = []

    method agregarVehiculo(vehiculo) {
        vehiculosDelTaller.add(vehiculo)
    }

    method cantidadVehiculos() = vehiculosDelTaller.size()

    method vehiculosAReparar() = vehiculosDelTaller.filter({ vehiculo => vehiculo.necesitaRevision() })

    method vehiculosUsados() = vehiculosDelTaller.filter({ vehiculo => vehiculo.vehiculoMuyUsado() })

    method totalEnReparaciones() = vehiculosDelTaller.map({ vehiculo => vehiculo.costoTotalDeReparacion() }).sum()

    method reparacionesCaras() = vehiculosDelTaller.map({ vehiculo => vehiculo.reparacionesCaras() }).flatten()
}