class Equipo {
    var funcionamiento = 100
    var  fallasPendientes = []

    method funcionameientoTotal() = funcionamiento

    method vivirUnDia() {
    fallasPendientes.forEach({ falla => falla.disminuirVida(self) })
    }

    method disminuirFuncionamiento(cantidad) {
    funcionamiento = 0.max(funcionamiento - cantidad)
    }

    method equipoinutilizable() = funcionamiento == 0
}

class Falla{
    var gravedad = 0
    var costoBase = 0 

    method fallaCara() = costoBase > 30000
}

class fallaHardware inherits Falla{

    method disminuirVida(equipo) {
    equipo.disminuirFuncionamiento(gravedad)
    }
}

class fallaSoftware inherits Falla{
    var cantidadDeErroresActivos = 0

    method disminuirVida(equipo) {
    equipo.disminuirFuncionamiento(cantidadDeErroresActivos / 2)
    }
}

const fallaPlaca = new fallaHardware(
    gravedad = 20,
    costoBase = 40000
)

const errorWindows = new fallaSoftware(
    cantidadDeErroresActivos = 10,
    costoBase = 20000
)

const noteBook = new Equipo(
    funcionamiento = 100,
    fallasPendientes = [fallaPlaca, errorWindows]
)