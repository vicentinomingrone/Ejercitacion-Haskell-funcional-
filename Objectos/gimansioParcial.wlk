class Socio {
    const nombre 
    var edad
    var peso 
    var entrenamientosRecibidos = []

    method costoTotal() = entrenamientosRecibidos.map({entrenamientos => entrenamientos.costoTotal()}).sum()

}

class ComunS inherits Socio {
}
class Premium inherits Socio {
    override method costoTotal() = super() * 0.80
}

class Vip inherits Socio {
    override method costoTotal() = super() + 10000
}

class Entrenamiento {
    var descripcion
    var costoBase
    var duracion

    method costoTotal() = costoBase

}

class ComunE inherits Entrenamiento {
}
class Intensivo inherits Entrenamiento {
    override method costoTotal() = super() * 1.5
}

class Personalizado inherits Entrenamiento {
    override method costoTotal() = super() + 15000
}


const carlos = new ComunS (
    nombre = "Carlos",
    edad = 45,
    peso = 85
) 

const marta = new Premium (
    nombre = "Marta",
    edad = 68,
    peso = 65 
)

const roberto = new Vip (
    nombre = "Robert",
    edad = 55,
    peso = 125 
)

const musculacion = new ComunE (
    descripcion = "Ejercicios de Msuculacion",
    costoBase = 20000,
    duracion = 60
)

const crossfit = new Intensivo (
    descripcion = "Crossfit es una de la mejores diciplinas",
    costoBase = 30000,
    duracion = 45
)

const entrenamientoPersona = new Personalizado (
    descripcion = "Ejercicios de Personalizados para la persona que queira",
    costoBase = 35000,
    duracion = 90
)
