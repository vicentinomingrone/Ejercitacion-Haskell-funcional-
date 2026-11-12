class Empleado{
    var salud 
    const habilidades = []  



    method completarMision()

    method agregarHabilidad(habilidad){
        habilidades.add(habilidad)
    }
    

    method puedeUsar(habilidad)= not(self.empleadoIncapacitado()) && self.tieneHabilidad(habilidad)
    

    method tieneHabilidad(habilidad)= habilidades.contains(habilidad)

    method saludCritica() 
    method empleadoIncapacitado() = salud < self.saludCritica()

    method esJefe()

    
}   


class Espias inherits Empleado{
        

    method completarMision(habilidad){
      habilidades.add(habilidad)
    } 


    override method saludCritica() = 15 
     
}

class Oficinista inherits Empleado{
    var estrella = 0

    override method completarMision(){
        if(self.sovrevivir()){
            self.agregarEstrella(1)
        }
    }

    method sovrevivir()
    
    override method saludCritica()= 40 - 5 * estrella 
     
    method agregarEstrella(numero) {
        estrella += numero
    }   
    
}

class Jefe inherits Empleado{
    const subordinados = []


    method agregarSubordinados(subordinado) {
        subordinados.add(subordinado)
    }

    override method puedeUsar(habilidad) = super(habilidad) || subordinados.any({s => s.puedeUsar(habilidad)})
}

object mision{
    const habilidadesRequeridas = []

    method puedeSerRealizadaPor(empleado) = habilidadesRequeridas.all({
        habilidad => empleado.puedeUsar(habilidad)
    })
}

object equipo{
    const empleados = []

    method puedeUsar(habilidad) = empleados.any({empleado => empleado.puedeUsar(habilidad)})
}