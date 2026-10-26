class Mascota {
    const nombre 
    var edad
    var peso
    var tratamientosQueRecibio = []


    method recibeUnTratamiento(tratamiento){
        tratamientosQueRecibio.add(tratamiento)
    }

    method costoTotalTratamientos() = tratamientosQueRecibio.map({tratamiento => tratamiento.costoTotal()}).sum()
    
    method mascotaVieja() = edad > 10

    method necesitaControlEspecial() = edad > 12 || peso > 40

}

class Perro inherits Mascota {
} 


class Gato inherits Mascota {
     override method costoTotalTratamientos() = super() + 5000
} 

class Conejo inherits Mascota {
    override method costoTotalTratamientos() = super() * 0.90
} 

class Tratamiento {
    var descripcion
    var costoBase 
    const duracion

    method costoTotal() = costoBase 

    method tratamientoCaro() =  self.costoTotal() > 30000
}


class Comun inherits Tratamiento{
}

class Urgente inherits Tratamiento{
    override  method costoTotal() = super() * 1.5
}

class Especial inherits Tratamiento{
    override  method costoTotal() = super() + 10000 
}

const firulais = new Perro (
    nombre = "Firulais",
    edad = 8,
    peso = 25
)

const michi = new Gato (
    nombre = "Michi",
    edad = 13,
    peso = 6
)

const tambor = new Conejo (
    nombre = "Tambor",
    edad = 4,
    peso = 3
)

const vacuna = new Comun (
    descripcion = "Vacuna para vivir",
    costoBase = 15000,
    duracion = 1
)

const cirugia = new Urgente (
    descripcion = "Cirugia para poder vivir",
    costoBase = 40000,
    duracion = 3
)
const rehailitacion = new Especial (
    descripcion = "Rehabilitacion para poder vivir",
    costoBase = 50000,
    duracion = 10
)

object veterinaria {

    var mascotas = []

    method agregarMascotas(mascota) {
        mascotas.add(mascota)
    }

    method cantidadMascotas() = mascotas.size()

    method mascotasViejas() = mascotas.filter({mascota => mascota.mascotaVieja()})

    method mascotasControlEspecial() = mascotas.filter({mascota => mascota.necesitaControlEspecial()})

    method costoTotalVeterinaria() = (mascotas.map({mascota => mascota.costoTotalTratamientos()})).sum()
    
    method tratamientosCaros() = mascotas.map({ mascota => mascota.tratamientosQueRecibio() }).flatten().filter({ tratamiento => tratamiento.tratamientoCaro() })

}