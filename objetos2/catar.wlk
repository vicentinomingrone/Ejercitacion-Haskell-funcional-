class Plato{ 
    

    method calorias() = 3* self.cantAzucar() + 100

    method cantAzucar()
    method esBonito() 
}

class Entrada inherits Plato{
    
    override method cantAzucar() = 0
    override method esBonito() = true
    
}

class Principal inherits Plato{
    const azucar 
    const bonito

    override method cantAzucar() = azucar
    override method esBonito() = bonito 

}

class Postre inherits Plato{
    var colores 

    override method cantAzucar() = 120
    override method esBonito() = colores >= 3
}

class Cocinero{
    var especialidad 

    method cambiarEspecilidad(nuevaEspecialida){
        especialidad = nuevaEspecialida
    }
    method catarPlato(plato)

    method cocinar()

    method presentarPlato()

}

class Pastelero inherits Cocinero{
    const nivelDeseadoDulzor

    override method cocinar() = new Postre(colores = nivelDeseadoDulzor / 50)

    override method catarPlato(plato) = (5 * plato.cantAzucar()/nivelDeseadoDulzor).min(10)
}

class Chef inherits Cocinero{
    var cantCaloricas

    method cumpleEspectativa(plato) = plato.esBonito() && plato.calorias() <= cantCaloricas

    override method catarPlato(plato){
        if(self.cumpleEspectativa(plato)){
            return 10 
        } return 0 
    }
    override method cocinar() = new Principal(azucar = cantCaloricas, bonito= true)
}

class Souschef inherits Chef{
   
   override method catarPlato(plato){
    if(!self.cumpleEspectativa(plato)){
       return (plato.calorias()/100).min(6)
    }
    return 10 
   }
   override method cocinar() = new Entrada()
}


class Presentacion {
    const cocinero
    const plato

}

class Torneo{
    const presentaciones = []

    method participa(cocinero) {
    const plato = cocinero.cocinar()
    presentaciones.add(
        new Presentacion(
            cocinero = cocinero,
            plato = plato
        )
    )
}



}