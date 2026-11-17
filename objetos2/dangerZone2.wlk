class Empleado{
    var salud 
    const habilidades = []

    method estaIncapacitado() = salud < self.saludCritica()

    method sovervive() = salud > 0 

    method puedeUsar(habilidad) =
    !self.estaIncapacitado() && habilidades.contains(habilidad)

    method salud() = salud
    method completarMision(mision)
    method saludCritica() 
}

class Oficinista inherits Empleado{
        var estrellas 

    override method completarMision(mision){
        if(self.sovervive()){
        estrellas += 1 
        }
    }

    override method saludCritica() = 40 - 5 * estrellas
}

class Espias inherits Empleado{

    override method completarMision(mision){
        mision.filter({habilidad => habilidad.susHabilidades()})
        habilidades.add()
    }

   override method saludCritica() = 15
   
}

class Mision{
     const habilidades = #{}

     method susHabilidades(){
        habilidades.filter()
     }


}