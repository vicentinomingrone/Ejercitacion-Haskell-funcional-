class Plato{
    const cocinero 
    const baseCalorica = 100 

    method cocinero() = cocinero 
    method cantidadAzucar()

    method cantidadCalorias() = 3 * self.cantidadAzucar() + baseCalorica 
}


class Entrada inherits Plato {

    override method cantidadAzucar() = 0
    method esBonito() = true 
}

class Principal inherits Plato {
    const esBonito
    const cantidadAzucar

    override method cantidadAzucar() = cantidadAzucar 
    method esBonito() = esBonito 
}

class Postre inherits Plato {
    const cantColores 

    override method cantidadAzucar() = 120
    method esBonito() = cantColores >3
    
}


class Cocinero{
    var especialidad

    method calificarPlato(plato)= especialidad.catarPlato(plato)

    method cambiarEspecialidad(nuevaEspecialidad) {
        especialidad = nuevaEspecialidad
    }

    method cocinar() = especialidad.cocinar(self)
}

class EspecializadoPastelero{
    var nivelDesadoAzucar 

    method catarPlato(plato) = (5*plato.cantidadAzucar()/nivelDesadoAzucar).min(10) 

    method cocinar(elCocinero) = new Postre(cocinero = elCocinero, cantColores = nivelDesadoAzucar / 50) 
}

class EspecialidadChef{
    var cantCaloriasDeseadas 

    method catarPlato(plato) {
        if(plato.esBonito() && plato.cantidadCalorias() <= cantCaloriasDeseadas){
            return 10
        } return 0 
    }

    method cocinar(elCocinero) = new Principal(cocinero = elCocinero, esBonito = true, cantidadAzucar = cantCaloriasDeseadas)
    
}

class Soucheff inherits EspecialidadChef {

    override method catarPlato(plato) = (plato.cantidadCalorias()/100).min(6)

    override method cocinar(elCocinero) = new Entrada(cocinero = elCocinero)
}