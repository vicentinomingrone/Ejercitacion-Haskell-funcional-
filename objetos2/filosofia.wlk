class Filosofo{
    const nombre 
    var edadEnDias
    var nivelDeIluminacion
    const actividades = []
    const honorificos = []

    method agregar(honorifico){
        if(honorificos.contains(honorifico)){
           throw new Exception(message = "no se puede agregar duplicado")
        }
        honorificos.add(honorifico)
    }

    method nivelDeIluminacion() = nivelDeIluminacion

    method presentarse() = honorificos.join(", ") + ", " + nombre

    method estaCorrecto() = nivelDeIluminacion > 1000

    method disminuirIluminacion(cantidad) {
        nivelDeIluminacion -= cantidad
    }

    method aumentarIluminacion(cantidad){
        nivelDeIluminacion += cantidad
    }

    method rejuvenecer(cantidad){
        edadEnDias -= cantidad
    } 

    method envejecer(cantidad){
        edadEnDias += cantidad
    }
    method vivirUnDia(){
        actividades.forEach({actividad => actividad.hacer(self)})
        self.envejecer(1)
    }
    method cumplirAnio(){
        if(edadEnDias%365 == 0){
            self.aumentarIluminacion(10)
        }
    }

    method cumplirSesenta(){
        if(edadEnDias == 21900){
            self.agregar("EL Sabio")
        }
    }
}

class Actividad{


    method hacer(filosofo)
    
}

object tomarVino{

    method hacer(filosofo) {
        filosofo.disminuirIluminacion(10)
        filosofo.agregar("El Borracho")
    }
}

class JuntarseAgora{
    const otroFilosofo

    method hacer(filosofo){
        filosofo.aumentarIluminacion(otroFilosofo.nivelDeIluminacion() * 0.1)
    }   
}

object admirarpaisaje{
    method hacer(filosofo){

    }
}

class MeditarEnCascada{
    const metrosDeCascada

    method hacer(filosofo) {
        filosofo.aumentarIluminacion(metrosDeCascada* 10)
    }
}


class Deportes inherits Actividad {
    const deporte

    override method hacer(filosofo) {
        filosofo.rejuvenecer(deporte.diasQueRejuvenece())
    }
}

object futbol {
    method diasQueRejuvenece() = 1
}

object polo {
    method diasQueRejuvenece() = 2
}

object waterPolo {
    method diasQueRejuvenece() = polo.diasQueRejuvenece() * 2
}


class Argumento{
    const descripcion 
    const naturaleza    

    method esEnriquecedora() = naturaleza.esEnriquecedora(descripcion)
}

object estoica {
    method esEnriquecedora(descripcion) = true
}

object moralista {
    method esEnriquecedora(descripcion) =
        descripcion.words().size() >= 10
}

object esceptica {
    method esEnriquecedora(descripcion) =
        descripcion.endsWith("?")
}

object cinica {
    method esEnriquecedora(descripcion) =
        1.randomUpTo(10) <= 3
}

class Combinadas {
    const naturalezas = []

    method esEnriquecedora(descripcion) = naturalezas.all({ naturaleza => naturaleza.esEnriquecedora(descripcion) })
}

class Partido{
    const filosofo 
    const argumentos = []

    method agergarArgumentos(argumento) {
        argumentos.add(argumento)
    }
}

class Discusion {
    const partidos = []

    method esBuena() {
        const todosLosArgumentos =
            partidos.flatMap({ partido => partido.argumentos() })

        const enriquecedores =
            todosLosArgumentos.filter({ argumento => argumento.esEnriquecedora() })

        return enriquecedores.size() >= todosLosArgumentos.size() * 0.5
            && partidos.all({ partido => partido.filosofo().estaCorrecto() })
    }
} 
