class Filosofo{
    const nombre 
    var edadEnDias
    var nivelIluminacion
    const actividades = []
    const honorificos = []


    method agregar(honorifico){
        if(honorificos.contains(honorifico)){
            throw new Exception(message = "no puede agregar, ya esta en la lista")
        }

        honorificos.add(honorifico)
    }

    method nivelDeIluminacion() = nivelIluminacion

    method presentarse() = honorificos.join(" , ") + " " + nombre

    method esCorrecto() = nivelIluminacion > 1000

    method disminuirIluminacion(cantidad){
        nivelIluminacion -= cantidad
    }

     method aumentarIluminacion(cantidad){
        nivelIluminacion += cantidad
    }

    method rejuvenecer(cantidad){
        edadEnDias -= cantidad
    }

    method envejecer(cantidad){
        edadEnDias += cantidad
    }

    method cumpleAnios(){
        if(edadEnDias%365 == 0){
            self.aumentarIluminacion(10)
        }
    }

    method cumpleSecenta(){
        if(edadEnDias == 21900){
            self.agregar("El Sabio")
        }
    }

    method vivirUnDia(){
        actividades.forEach({actividad => actividad.hacer(self)})
        self.envejecer(1)
    }
}

class Actividad{

    method hacer(filosofo)
}

object tomarVino{

    method hacer(filosofo){
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

object admirarPaisaje{
    method hacer(filosofo){

    }
}

class MeditarEnLaCascada{
    const metros 

    method hacer(filosofo){
        filosofo.aumentarIluminacion(10 * metros)
    }
}

class Deportes{
    var deporte

    method hacer(filosofo){
        filosofo.rejuvenecer(deporte.diasARejuvenecer())
    }
}

object futbol{
    method diasARejuvenecer() = 1
}

object polo{
    method diasARejuvenecer() = 2
}

object waterPolo{
    method diasARejuvenecer() = polo.diasARejuvenecer() * 2 
}