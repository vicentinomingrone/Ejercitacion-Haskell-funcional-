class Vehiculo {
    const property nombre
    var property combustible
    var property kilometros
    var property modoConsumo 

    method cargaDeCombustible(litros) {
        combustible = combustible + litros
    }

    method hacerService() {
      kilometros = 0
    }

    method consumir(kilometro) {
        combustible = combustible - modoConsumo.consumoPara(kilometro)
    }

    method puedeViajar(kilometro)=
        combustible >= modoConsumo.consumoPara(kilometro)

    method viajar(kilometro){
        if(self.puedeViajar(kilometro))
        {
            kilometros = kilometros + kilometro
            self.consumir(kilometro)
        }else {
            self.error("No Puede Viajar ñoño, no hay combustible suficiente")
        }
    }
}

object consumoEconomico{
    method consumoPara(kilometro)= kilometro/20
}
object consumoNormal{
   method consumoPara(kilometro)= kilometro/10
}

object consumoDeportivo{
    method consumoPara(kilometro)= kilometro/5
}

class Auto inherits Vehiculo{
    override method viajar(kilometro){
        super(kilometro)
        combustible = combustible + 1
    }

}

class Camioneta inherits Vehiculo{

    override method viajar(kilometro){
        super(kilometro)
        combustible = combustible -2
    }
}

const golTrend = new Auto(
    nombre = "Gol Trend",
    combustible = 20,
    kilometros = 50000,
    modoConsumo = consumoDeportivo
)

const fordRaptor = new Camioneta(
    nombre = "Ford Raptor 1500",
    combustible = 40,
    kilometros = 80000,
    modoConsumo = consumoDeportivo
)

const fiatCronos = new Auto(
    nombre = "Fiat Cronos",
    combustible = 100,
    kilometros = 0,
    modoConsumo = consumoNormal
)

