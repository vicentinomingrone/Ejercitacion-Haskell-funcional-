class Paciente {
    var nivelSalud = 100
    var enfermedades = []

    method cuantaSalud() = nivelSalud

    method vivirUnDia(){
        enfermedades.forEach ({enfermedad => enfermedad.disminuirVida(self)})
    }

    method disminuirFuncionamiento(cantidad){
        nivelSalud = 0.max(nivelSalud - cantidad)
    }
    method cuantasEnfermedadesTengo()= enfermedades.size()

    method pacienteCritico() = nivelSalud == 0 

    method agregarEnfermedad(enfermedad){
        enfermedades.add(enfermedad)
    }
    
    method enfermedadesCaras() {
        (enfermedades.filter({ infecciones => infecciones.enfermedadCara()}))
    }
}


class Enfermedades {
    var intensidad = 0
    var cantidadSintomas = 0 
    var costoBase = 0 

    method enfermedadCara() = costoBase > 25000
}

class enfermedadesLeves inherits Enfermedades{
    method disminuirVida(paciente) {
        paciente.disminuirFuncionamiento(intensidad)
    }
    method disminuirIntensidad(cantidad){
        intensidad = intensidad - cantidad
    }
}

class enfermedadesGraves inherits Enfermedades {
    method disminuirVida(paciente){
        paciente.disminuirFuncionamiento(cantidadSintomas/2)
    }
    method disminuirIntensidad(cantidad){
        intensidad = intensidad - cantidad*2
    }
}

const gripe = new enfermedadesLeves (
    intensidad = 15,
    costoBase = 30000
)

const infeccion = new enfermedadesGraves (
    cantidadSintomas = 20,
    costoBase = 20000
)

const juan = new Paciente (
    nivelSalud = 100
)

class Medico {
    const capacidad

    method atender(paciente) {
        paciente.forEach({enfermedad => enfermedad.disminuirIntensidad()})
    }

}


const doctorHouse = new Medico (
    capacidad = 10 
)

const cameron = new Medico (
    capacidad = 20 
)


