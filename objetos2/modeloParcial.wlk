class Tripulante {                                
   var property rolActual 
   var property edad
   var property fuerza


   method mayorDeEdad() = self.edad() >= 18   	
   method prestigio() = rolActual.prestigio()

    method podesCambiarA(otroRol) = otroRol.puedeSerOcupante(self)
   	
   method cambiarRol(otroRol){
    if(self.podesCambiarA(otroRol)){
        rolActual = otroRol
    } else {
        throw new Exception(message = "No cumple los requisitos")
    }
}
   		
   
}


object libre {

    method prestigio() = 0

    method puedeSerOcupante(tripulante) = true 
}

object obrero{

    method prestigio() = 50
    
    method puedeSerOcupante(tripulante) = tripulante.mayorDeEdad() && tripulante.fuerza() > 50
}

class RolInteligente {
    const property conocimiento

    method cumpleConocimiento() =
        conocimiento > estacionEspacial.conocimientoPromedio() * 1.21
}
class MrFusion inherits RolInteligente {
    method prestigio() = 100

    method puedeSerOcupante(tripulante) =
        tripulante.mayorDeEdad() &&
        self.cumpleConocimiento()
}
class Capitan inherits RolInteligente {
    method prestigio() = 100

    method puedeSerOcupante(tripulante) =
        tripulante.mayorDeEdad() &&
        self.cumpleConocimiento() &&
        tripulante.fuerza() > 73
}

object estacionEspacial{
    const conocimiento = 0

    method conocimientoPromedio() = conocimiento
}



class Calendario {
    var eventos

    method estaLibre(fecha) =
        eventos.all({ evento => not evento.ocupa(fecha) })
}

class EventoDiaCompleto {
    var property fecha

    method ocupa(unaFecha) =
        fecha == unaFecha
}

object recordatorio {
    method ocupa(fecha) = false
}

class EventoVariosDias {
    const fechasTomadas = []

    method ocupa(fecha) =
        fechasTomadas.contains(fecha)
}