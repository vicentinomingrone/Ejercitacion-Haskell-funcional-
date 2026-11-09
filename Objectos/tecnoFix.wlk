class Equipo{
    var funcionamiento = 100
    var fallasPendientes = []


    method equipoInservible() = funcionamiento == 0 
}


class Falla {

}


class fallaHardware inherits Falla {
    var gravedad
    var property funcionamiento  

    method afectarEquipo(gravedad) {
        funcionamiento = funcionamiento - gravedad
    }
}

class fallaSoftware inherits Falla {
    var erroresActivos
    var property funcionamiento  

    method afectarEquipo(erroresActivos) {
        funcionamiento = funcionamiento - erroresActivos
    }
}