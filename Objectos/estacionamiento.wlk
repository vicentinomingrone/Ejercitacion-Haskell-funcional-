class Vehiculo {
    const property nombre
    var property combustible 
    var property kilometros 
    var property modoConsumo 


    method viajar(kilometro){
        kilometros = kilometros + kilometro
        self.consumir(kilometro)   
    }
     method consumir(kilometro) {
        combustible = combustible - modoConsumo.consumoPara(kilometro)
    }
    method puedeViajar(kilometro)=
        combustible >= modoConsumo.consumoPara(kilometro)
    
}

// Objetos y sus clases, auto y camioneta 

class Auto inherits Vehiculo {
     override method viajar(kilometro) {
        super(kilometro)
        combustible = combustible + 1
     }
}

class Camioneta inherits Vehiculo {
    override method viajar(kilometro) {
        super(kilometro)
        combustible = combustible - 2 
     }
    
}

const golTrend = new Auto (

    nombre = "Gol Trend",
    combustible = 50,
    kilometros = 90000,
    modoConsumo = consumoNormal  
)

const ramMaverick = new Camioneta (

    nombre = "Ram Maverick",
    combustible = 100,
    kilometros = 1000,
    modoConsumo = consumoDeportivo  
)

// Consumo 

object consumoNormal{
    method consumoPara(kilometros) = kilometros/10 
}

object consumoDeportivo{
    method consumoPara(kilometros) = kilometros/5 
}

object estacionamiento {

    var property vehiculos = [golTrend, ramMaverick] 

    method cantidadDeVehiculos() = vehiculos.size() 

    method vehiculosQuePuedenViajar(kilometro){
        vehiculos.filter({vehiculo => vehiculo.puedeViajar(kilometro) })
    }

    method kilometrosTotales() =
        vehiculos.map({ vehiculo => vehiculo.kilometros() }).sum()

}